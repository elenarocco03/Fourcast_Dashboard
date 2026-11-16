# Yield curve models: working instructions

Context for agents (Claude, Codex) working on the model estimation. Read together with
`AGENT.md`. Last updated: 16 Nov 2026.

## Goal

Implement, in this order, three models for U.S. yield curve forecasting:

1. **PCA**
2. **Vasicek**
3. **Stochastic volatility** (Fong-Vasicek, Mele eq. 11)

We want a **flexible MVP**: the aim is to move quickly from one model to the next, not to
settle every theoretical point. When a modelling choice is debatable, implement it as an
option (a flag or parameter), explain the trade-off, and let the user decide. Do not bake
it in.

## Scope right now

- **In scope:** estimation of the models on a fixed sample, from 2010 to the latest date.
- **On hold:** the dashboard. Do not edit `dashboard.m` until told to; the models must
  still be written so they can be wired in later (no hard-coded dates or samples inside
  model functions).
- **Not required:** forecast backtests. Do not build one, and avoid anything that uses
  future data at an earlier date (look-ahead bias).
- **PCA is done by a colleague in parallel.** Do not write a competing PCA. The user will
  `git pull` their work; after that we adapt it to the shared data input if needed.

## Theory and notation

- Follow the notation of the material in `theory/` (Mele notes, Tutorials 1-4).
- Readable versions are in `theory/md/` (local only, `theory/` is git-ignored).
  The Mele notes lose their formulas in the automatic conversion: use
  `theory/md/models_reference.md`, transcribed by hand with page references.

## Data

- Source: `fred_yield_history.m` (daily FRED constant-maturity yields, timetable `T`, in %).
- Sample: from **2010-01-01** by default, always passed as a parameter.
- Maturities: the **10 published ones, 1M to 20Y**. Do not use the 15Y that the dashboard
  interpolates (it is not real data). The 30Y is left out.
- Units: models work in **decimals**; convert from % on input.
- Short-rate proxy: the **3M** yield.
- Frequency: support both **daily** and **monthly** (month-end). Models take the time step
  `dt` from the data (1/252 daily, 1/12 monthly), so they work at either frequency.
- Known simplification: FRED yields are par yields; we treat them as zero-coupon yields.
  State this in the write-up.

## Shared code (bare essentials only)

- `yield_sample(T, from, freq)` returns a struct `data` with
  `dates`, `tau` (maturities in years), `Y` (n x p, decimals), `r` (3M yield), `dt`.
- Naming convention for every model (so the dashboard can call them later):
  - `<model>_fit(data)` returns a `params` struct
  - `<model>_yields(params, state, tau)` returns model yields
  - `<model>_forecast(params, state, tau, h)` returns mean and standard deviation
- Nothing else for now: no forecast structs, no test harness.

## 1. PCA (colleague)

- Factor model `R_t = Rbar + B F_t + eps_t` (Mele eq. 1); eigen-decomposition of the
  covariance, keep 3 factors (level, slope, curvature), report explained variance and
  loadings.
- Only alignment needed: same input (`yield_sample` output). Whether PCA is on yield
  levels or yield changes (Tutorial 4 uses changes) is their choice; it must be stated.
- Forecasting the factor scores (e.g. AR(1) on each score) is decided after the pull.

## 2. Vasicek

Model (Mele eq. 7): `dr = kappa (rbar - r) dtau + sigma dW`. Yields from eq. (10) with
`A`, `B` from Mele p. 121.

Steps:

1. **Dynamics (kappa, rbar, sigma)**: OLS on the exact discretisation, an AR(1):
   `r(t+dt) = a + b r(t) + e`, with `b = exp(-kappa dt)`, `a = rbar (1 - b)`,
   `var(e) = sigma^2 (1 - exp(-2 kappa dt)) / (2 kappa)`.
   Print `b`, `kappa`, half-life `log(2)/kappa`, `rbar`, `sigma`, with standard errors.
   **Stop with a clear error if `b >= 1`** (kappa <= 0: the formulas break).
2. **lambda: OPEN, waiting for the professor.** We do not yet know whether lambda must be
   estimated or given as an input. Write the code so that lambda can be **passed in as a
   parameter**; do not implement an estimation method until the user confirms. (Option
   discussed if estimation is required: least squares on the cross-section of yields,
   after step 1.)
3. **Model yields**: eq. (10), `R = -A/tau + (B/tau) r`.
4. **Forecast**: closed form, Mele p. 123: conditional mean and variance of `r`, mapped
   to yields through `A` and `B`.
5. **Script**: 2010 to today, run at daily and monthly frequency; parameter table, fitted
   vs observed curve on the last date, one forecast with +/- 1 s.d. band.

Things to expect and report (do not try to fix them in the MVP):

- **Persistence close to 1.** `b` is near 1 by construction at monthly/daily frequency;
  more importantly, the 2010-2026 sample (zero lower bound 2010-15, then long
  policy-driven trends) carries little information on mean reversion. Consequences:
  `rbar = a / (1 - b)` is very unstable across samples; `kappa` may come out <= 0; OLS is
  biased towards too-fast mean reversion in small samples; a small `kappa` makes the
  long end (`sigma/kappa` terms in `r_inf`) very sensitive. Showing results at both
  frequencies and possibly two sample starts makes the sensitivity visible.
- **sigma is an average** of the near-zero volatility at the zero lower bound and the high
  volatility of 2022: this is the motivation for the stochastic volatility model.

### Open option: anchoring the forecast to today's curve (user decides)

The model curve does not match today's observed curve. That is expected (Vasicek is not a
calibration model) and not a mistake. The question is only how to present the forecast.
Let `e(tau)` = observed yield - model yield today.

- **Unanchored** (pure model): forecast = model expected curve. Over short horizons the
  forecast change is dominated by `-e(tau)`, i.e. "the curve jumps onto the model curve".
- **Anchored**: forecast = today's observed curve + the model's predicted change
  (equivalently, hold `e(tau)` constant). Bands are unchanged. Ad hoc, and it hides the
  model's misfit, which is informative in itself.
- A descriptive in-sample check helps decide: the AR(1) persistence of `e(tau)` by
  maturity (near 1 favours anchoring; fast decay favours unanchored; a middle option is to
  let `e` decay at its estimated speed).

Implement as a single flag (e.g. `anchor = true/false`), default to be decided by the user.

## 3. Stochastic volatility (estimation only)

Model (Mele eq. 11, with `gamma = 0`; Tutorial 1 slides 36-38):
`dr = kappa_r (rbar - r) dtau + sqrt(v) dW1`,
`dv = kappa_v (vbar - v) dtau + xi_v sqrt(v) dW2`, `dW1 dW2 = rho dt`.
Bond price `P = exp(A(u) - B(u) r + C(u) v)`; `B` as in Vasicek, `A` and `C` solved
numerically (`ode45`, base MATLAB).

Steps:

1. Measure `v` as the monthly realised variance of daily changes in `r` (this needs daily
   data even when the model is monthly).
2. Fit the CIR equation for `v` by weighted OLS on its discretisation; check the Feller
   condition `2 kappa_v vbar >= xi_v^2`.
3. Fit the `r` equation given `v` by weighted OLS; estimate `rho` from the residuals.
4. Risk premia `lambda_r`, `lambda_v` (both proportional to `sqrt(v)`, Mele p. 130):
   **same open point as Vasicek lambda**, keep them as inputs for now.

**Forecast: left open.** Do not implement it yet.

Optional cross-check later: correlate the estimated `v` with the PCA curvature scores
(Mele p. 133 suggests the volatility factor behaves like curvature).

## Git

- Work on a branch, not on `main`.
- Each model in its own files; do not touch `dashboard.m` (single file, conflict-prone).
