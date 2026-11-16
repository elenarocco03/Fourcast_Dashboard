# Project journal

Running record of the Fourcast project: what was done, **which decisions were taken and
why**, the limitations found and the open points. It is the raw material for the final
report (`REPORT_BRIEF.md`, `report/report.md`).

Rules (full version in `AGENT.md`):

- Every commit that reaches `main` adds or extends an entry here, in the same commit.
- One entry per author and working day, newest at the bottom.
- Results and reasons only, not the discussion that led to them. Numbers come from running
  our code. A reason nobody recorded is written `[TODO: ask <author>]`, never invented.

Entry template:

```
## YYYY-MM-DD | author | short title
Commits: <hashes or "this commit">

**Done**
- ...

**Decisions and reasons**
| Decision | Alternative | Reason |
|---|---|---|

**Results** (only numbers produced by our code)

**Limitations**
- ...

**Open points**
- ...
```

---

## 2026-10-19 | elenarocco03 | Data download and first dashboard
Commits: e7e5f39, e771ad6, 17530fe

**Done**
- `fred_yield_curve.m`: downloads the 11 U.S. Treasury constant-maturity series
  (1M-30Y, FRED H.15) through the FRED API.
- `fred_yield_history.m`: keeps the daily history since 1962 in `data/` and downloads only
  the last weeks at later runs.
- `setup_fred_key.m`: stores each user's FRED API key in `~/.fred_api_key`.
- `dashboard.m`: Today tab (latest curve, key numbers) and History tab (animated curve).

**Decisions and reasons**
| Decision | Alternative | Reason |
|---|---|---|
| API key in the user's home folder, git-ignored | Key in the code or the repository | The key is personal; FRED requires each user to have their own (README) |
| Local cache of the history in `data/`, git-ignored | Download everything at every start | Faster start: later runs download only the last weeks (README) |
| 15Y interpolated between 10Y and 20Y in the charts | Leave the 15Y out | [TODO: ask elenarocco03] |

**Limitations**
- FRED yields are par yields, not zero-coupon yields.
- The 20Y is missing between 1987 and 1993; the 1M starts on 31 Jul 2001.

---

## 2026-11-16 | elenarocco03 | Theory material and working plans
Commits: 714beae, 73279a8, b1d6400, b7069bd, 4fc88ef

**Done**
- Lecture material in `theory/` (Mele notes, Tutorials 1-4) and Markdown versions in
  `theory/md/`; `models_reference.md` with the model formulas transcribed by hand.
- `AGENT.md`: rules for the agents (simple, readable code; code ready for the dashboard;
  notation of the course).
- `MODELS_PLAN.md`: models, data conventions, function naming
  (`<model>_fit`, `<model>_yields`, `<model>_forecast`).
- `TEACHER_INSTRUCTIONS`: models and variants required by the teacher, grading.
- `REPORT_BRIEF.md`: instructions for writing the final report.

**Decisions and reasons**
| Decision | Alternative | Reason |
|---|---|---|
| Formulas of the Mele notes transcribed by hand | Use the automatic PDF conversion | The automatic conversion loses the formulas |
| Flexible MVP: debatable choices implemented as options | Settle every choice first | Move quickly from one model to the next (`MODELS_PLAN.md`) |
| Short rate = 3M yield; models in decimals; 10 published maturities 1M-20Y | 1M as short rate; include 15Y/30Y | [TODO: ask elenarocco03] (15Y left out because it is not real data) |

**Open points**
- Model 3 differs between documents: `MODELS_PLAN.md` says stochastic volatility
  (Fong-Vasicek), `TEACHER_INSTRUCTIONS` says Vasicek plus one PCA factor.

---

## 2026-11-16 | Matteo | PCA engine, PCA section, Control panel, Vasicek lambda fit
Commits: 7ae9751, and the Vasicek lambda fit commit

**Done**
- `pca_curva.m`: PCA engine (eigenvectors of the covariance, variance shares, scores).
  Signs fixed as in Mele p. 91 (PC1 positive, PC2 positive at the short end, PC3 positive
  at both ends). Checked on the Tutorial 4 example (eigenvalues 7 and 1, PC1 87.5%).
- `pca_campione.m`: PCA on daily changes of the 11 maturities over the whole sample, with
  levels for comparison.
- `dashboard.m`: Control panel (maturities for Today/History, PCA period and frequency,
  Apply) and PCA section on yield **levels**, maturities 1Y-20Y as in Mele p. 91 without
  the 30Y (15Y interpolated), sub-tabs Loadings and Factors.

**Decisions and reasons**
| Decision | Alternative | Reason |
|---|---|---|
| Dashboard PCA on levels (Mele eq. 1) | Changes, as in Tutorial 4 | The teacher's chart of the factors over time matches a PCA on levels (shares 88.4 / 10.6 / 0.8% on the teacher's chart; `pca_campione.m`, levels 2001-2026 with the 30Y: 88.3 / 10.4 / 1.0%; daily changes: 68.3 / 16.2 / 7.8%), and Mele eq. 1 is written on levels. The PCA on changes stays in `pca_campione.m` |
| Maturities 1Y-20Y with the 15Y, as Mele p. 91 | All published maturities, no 15Y | Comparability with Mele p. 91: same maturity grid as his figure, without the 30Y (author's choice). The 15Y is (10Y + 20Y)/2, so it adds no information of its own (one eigenvalue is zero) and slightly raises the weight of the long end |
| Default PCA sample from 2004, monthly | Other start | Author's choice, not substantive: period and frequency can be changed in the Control panel |

**Results** (dashboard default, monthly levels, 01 Jan 2004 - 12 Nov 2026, 275 obs.)
- Variance shares: level 91.8%, slope 7.7%, curvature 0.4% (first three 99.9%).

**Vasicek lambda fit (dashboard section "Vasicek λ fit", teacher's exercise)**
- kappa, rbar, sigma typed on the page (default Mele p. 122: 0.20, 6%, 3%); r = today's 3M;
  lambda fitted by least squares on today's market curve at the maturities of the Control
  panel; market curve and Vasicek curve on one chart; cards: lambda fitted (with r_inf),
  short rate, fit error (RMSE). Continuous-time yields from `vasicek_yields.m`.
- Kept separate from the Vasicek section (estimation and forecast): here the parameters are
  chosen by hand and only lambda is fitted, on one day.

| Decision | Alternative | Reason |
|---|---|---|
| lambda in closed form, OLS through the origin | Numerical search | The model yield is linear in lambda: R = R0 + lambda g, g = -(1 - B/tau) sigma/kappa; same solution, no tuning |
| r = today's 3M, not an input | r typed by hand | Teacher's exercise: the short rate is observed; only kappa, rbar, sigma are chosen |
| 15Y excluded from the fit, shown on the market curve | Fit on all the Today maturities | The 15Y is interpolated, not market data |
| Continuous-time yields | Discrete recursion (board 7719) | Already validated on the slides; the discrete version is the next step, to be compared on the same chart |

**Results** (curve of 12 Nov 2026, all ten published maturities, from the dashboard)
- kappa 0.20, rbar 6%, sigma 3%: lambda = -0.045, r_inf = 5.55%, RMSE 12 bp (largest +22 bp
  at 1M: the model starts from the 3M and cannot go below it).
- kappa 0.60, same rbar and sigma: lambda = +0.104, r_inf = 5.35%, RMSE 12 bp.

**Limitations**
- One day, in sample: the fit error describes today's curve, it is not a forecast error.
- One factor: the model curve passes through the market curve but cannot follow its humps.

**Open points**
- The PCA does not use the shared input `yield_sample` yet (`MODELS_PLAN.md`).
- Discrete-time model (board 7719): implement with `yield_sample` and the sample from 2000,
  then compare with the continuous curve on the lambda fit chart.
- Teacher's request of a fit error week by week and its average: whether lambda is one for
  all weeks (board 7720 sums over t) or re-estimated each week is to be confirmed.

---

## 2026-11-16 | Sabrina | Vasicek (continuous time), dashboard section, journal
Commits: 7261e81, 3b4fcd7, 00d63f5, 6c3c649, 5a546e2, 6d6112c, and the journal commit

**Done**
- `yield_sample.m`: shared data input (10 published maturities 1M-20Y, decimals, 3M as short
  rate, daily or monthly with the last available day of each month, time step `dt`).
- `vasicek_yields.m`: model yields, Mele eq. (10) with A, B of Mele p. 121.
- `vasicek_slides_check.m`: replication of the slide examples (validation of the formulas).
- `vasicek_fit.m`: kappa, rbar, sigma by OLS on the exact discretisation (AR(1) of the 3M
  on itself) with delta-method standard errors; stops with an error if b >= 1; lambda by
  least squares on yields (closed form); persistence phi of the fit error per maturity.
- `vasicek_forecast.m`: conditional mean and s.d. h years ahead (Mele p. 123), option
  `anchor` = "decay" (default), "full", "none".
- `vasicek_run.m`: estimation from 2000 at daily and monthly frequency, parameter table,
  model vs observed curve, 3-month forecast with +/- 1 s.d. band.
- Dashboard: Vasicek section (parameter cards with s.e., fit on the last day, forecast with
  band and pure-model line) and a Vasicek card in the Control panel (sample start,
  frequency, horizon 1-120 months, anchor).
- Project journal set up: this file, rule in `AGENT.md`, `/journal` command, pre-commit
  hook and GitHub check.

**Decisions and reasons**
| Decision | Alternative | Reason |
|---|---|---|
| Validate the formulas on the slide examples first | Go straight to the data | Required by the teacher; on real data there is no known answer, so a wrong sign or factor would go unnoticed |
| Sample start 2000 (effective 31 Jul 2001, when the 1M starts) | 2010 (plan default) | From 2010 the 3M shows no mean reversion: AR(1) b = 1.00009 daily and 1.00002 monthly, i.e. kappa < 0 and rbar = a/(1-b) meaningless. Causes: 3M at zero in 2010-15 (mean 0.07%), then a trend from 0 to above 5% (2022-23) that stayed far above the sample mean (1.55%); after months above the mean the 3M rose further (+0.033 pp a month on average). From 2000 the sample contains full cycles |
| Do not start before 2000 | 1982, 1990 or 1994 start | Fit error 2001-26 on 3M-10Y unchanged (about 55 bp average) or worse (75 bp from 1982), and the 1M (and the 20Y before 1994) would have to be dropped. The misfit is structural: one factor gives one curve per value of r |
| lambda by least squares on **yields** | On bond prices | A price error is about tau P times the yield error, so a price criterion weighs the 20Y about 160 times the 1M and fits only the long end; FRED data, charts and forecasts are in yields; yields are linear in lambda, so the solution is in closed form and unique |
| lambda pooled over all dates (default) | Last date only (option `lambdaDates="last"`), or lambda given | More stable; the other two remain available |
| Forecast anchored, error decaying (`anchor="decay"`) | Pure model ("none") or constant error ("full") | The fit error is very persistent: after 3 months 68% (1Y) to 92% (20Y) of it is still there (monthly AR(1) phi 0.88-0.97 from 1Y up). The pure model forecast would predict a jump onto the model curve that does not happen; a constant error is wrong at long horizons. "decay" nests both (phi = 0 and phi = 1) |
| Bands unchanged by the anchor | Add the uncertainty of the error | MVP; to be stated as a simplification |
| Stop with an error if b >= 1 | Force estimates | The Vasicek formulas divide by kappa; the dashboard shows the message instead of crashing |

**Results** (data to 12 Nov 2026, from `vasicek_run` and `vasicek_slides_check`)
- Slide replication: r_inf = 5.1001% (Mele p. 122: 5.10%); Tutorial 4 prices
  0.959904, 0.919968, 0.880605 (identical to the slides).

| From 2000 | Monthly (305 obs.) | Daily (6,323 obs.) |
|---|---|---|
| b (s.e.) | 0.99530 (0.00645) | 0.99980 (0.00029) |
| kappa (s.e.) | 0.0565 (0.0778) | 0.0496 (0.0742) |
| half-life | 12.3 years | 14.0 years |
| rbar (s.e.) | 2.34% (2.65%) | 2.42% (2.92%) |
| sigma (s.e.) | 0.72% (0.03%) | 0.69% (0.01%) |
| lambda | -0.402 | -0.412 |
| RMSE 1M / 2Y / 10Y / 20Y | 16 / 48 / 103 / 108 bp | 16 / 49 / 107 / 112 bp |

- 3-month forecast, monthly, 2Y / 10Y: observed 4.86% / 5.10%; none 4.46% / 4.99%;
  decay 4.73% / 5.07%; full 4.83% / 5.08%.
- The comparison of sample starts (1982-2001) was an exploratory check with a script outside
  the repository; it is not reproduced by our code.

**Limitations**
- The standard errors of kappa and rbar exceed the estimates: mean reversion is weak even
  from 2000.
- One factor with constant parameters: errors around 1 pp at the long end and no hump at
  2-3 years.
- sigma averages the near-zero volatility of 2010-15 and the high volatility of 2022
  (motivation for stochastic volatility).
- The 3M is used as r, while the model's own 3M yield differs from r.
- phi is estimated on the whole sample: fine for a forecast from today, look-ahead in a
  backtest (none is planned).
- At daily frequency the short-maturity error decays faster (6M: 27% left after 3 months,
  60% monthly).

**Discrete-time Vasicek (review of the teacher's board, not implemented)**
- Board: p_t^(n) = E[m_{t+1} p_{t+1}^(n-1)], m_{t+1} = exp(-r_t Delta - lambda^2/2 -+ lambda eps_{t+1}),
  with r_{t+1} = c + phi r_t + sigma eps_{t+1}. With the sign -lambda eps:
  B_n = Delta + phi B_{n-1}, A_n = A_{n-1} + B_{n-1}(c - lambda sigma) - sigma^2 B_{n-1}^2 / 2,
  y_n = (A_n + B_n r_t) / (n Delta).
- With the same risk-neutral mean, lambda_discrete = lambda_continuous * sqrt(Delta)
  (-0.116 monthly) and the discrete curve matches the continuous one within 0.74 bp
  (exploratory check outside the repository).

**Open points**
- Discrete-time model: who implements it; definition of C(lambda) on board 7720 (prices or
  yields); sign of the lambda eps term (-lambda eps recommended, same convention as Mele).
- Model 3 definition (see the elenarocco03 entry).
- PCA and discrete model should use `yield_sample` and the same sample start.
