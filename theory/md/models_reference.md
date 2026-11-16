# Models reference: PCA, Vasicek, CIR, stochastic volatility

Formulas transcribed by hand from the page images, because the automatic conversion of
`Rate Credit Models.pdf` loses the math. "Mele p. N" is the **printed** slide number
(PDF page = N + 1). "T1/T4 slide N" refers to Tutorial 1 / Tutorial 4.

Notation: $r$ short rate, $\tau$ calendar time, $T$ maturity date, $T-t$ time to maturity,
$P$ zero-coupon bond price, $R$ continuously compounded spot rate (yield).

---

## 1. Yields and bonds (T1 slides 4-5, T2 slides 4-7)

$$P(T) = e^{-R(T)\,T}, \qquad R(T) = -\frac{1}{T}\ln P(T)$$

Coupon bond = portfolio of zeros: $B(T) = \sum_i C_{t_i} P(t_i) + P(T)$.

Nelson-Siegel (Mele p. 48), used by Diebold and Li (2006) to forecast the curve through
time-series models on the $\beta$'s:

$$R(T) = \beta_1 + \beta_2\left(\frac{1-e^{-\lambda T}}{\lambda T}\right) + \beta_3\left(\frac{1-e^{-\lambda T}}{\lambda T} - e^{-\lambda T}\right)$$

($\beta_1$ level, $\beta_2$ slope, $\beta_3$ curvature. This $\lambda$ is a decay
parameter, not the market price of risk.)

---

## 2. Factor model and PCA (Mele pp. 88-97, T4 slides 68-75 and 10-18)

Stylized facts (Mele p. 88): yields are highly correlated, **very persistent**, and the
term structure of unconditional volatility slopes downward.

Linear factor model, Mele eq. (1):

$$\underset{p\times1}{R_t} = \underset{p\times1}{\bar R} + \underset{p\times k}{B}\,\underset{k\times1}{F_t} + \underset{p\times1}{\epsilon_t}$$

$F_t$ zero-mean common factors, $B$ loadings (row: one yield's sensitivities; column: the
term structure of one factor's loadings), $\epsilon_t$ idiosyncratic.

PCA (Mele pp. 95-96): $Y_i = C_i^\top (R - \bar R)$, $i=1,\dots,p$, with $C_i$ the
eigenvector of $\Sigma = \mathrm{cov}(R)$ for eigenvalue $\lambda_i$
($\lambda_1 > \dots > \lambda_p$). Then $\mathrm{var}(Y_i) = \lambda_i$ and

$$R - \bar R = C^{\top-1} Y \;\approx\; \underset{p\times k}{C^{\top(k)}}\,\underset{k\times1}{Y^{(k)}}, \qquad
R_{PCA} = \frac{\sum_{i=1}^k \lambda_i}{\sum_{i=1}^p \lambda_i} \quad\text{(eq. 4)}$$

T4 derivation: maximise $w^\top \Sigma w$ s.t. $w^\top w = 1$, giving $\Sigma w = \lambda w$; scores
$Y_{k,t} = W_k^\top X_t$; reconstruction $\hat X_t = W_k Y_{k,t}$; $\mathrm{tr}(\Sigma) = \sum_j \lambda_j$.
In T4, $X$ = **yield changes minus their average**; Mele writes it for demeaned (excess) returns.

Typical U.S. result (Mele p. 91): level ~80%, slope ~15%, curvature ~5% of total variation.

ML alternative (Mele p. 94, Jöreskog 1967): with $F \sim N(0,I)$ and $\epsilon \sim N(0,\Psi)$,
$\Psi$ diagonal, $R \sim N(\bar R, \Sigma)$ with $\Sigma = BB^\top + \Psi$, and
$\text{log-lik} = -\tfrac12 N[\log|\Sigma| + \mathrm{Tr}(S\Sigma^{-1})]$, identified by
requiring $B^\top \Psi B$ diagonal with decreasing elements.

---

## 3. Short-rate pricing (Mele p. 116, T1 slide 31)

Short rate $dr = b(r)\,d\tau + a(r)\,dW$. No arbitrage, $\mu_P - r = \lambda \sigma_P$, gives the
pricing PDE, Mele eq. (5):

$$\frac{\partial P}{\partial \tau} + b P_r + \tfrac12 a^2 P_{rr} = rP + \lambda a P_r, \qquad P(r,T,T) = 1$$

$\lambda$ = **unit risk premium (market price of risk)**. Under $Q$ the drift becomes $b - \lambda a$.

---

## 4. Vasicek (Mele pp. 117, 120-123, T1 slide 33)

Mele eq. (7), under the historical measure:

$$dr_\tau = \kappa(\bar r - r_\tau)\,d\tau + \sigma\,dW_\tau, \qquad \kappa>0,\ \sigma>0$$

- $r$ is conditionally normal; stationary mean $\bar r$, variance $\sigma^2/(2\kappa)$.
- Drawbacks (Mele p. 117): $r$ can be negative; diffusion independent of the level
  (counterfactual "level effect").
- Closed form when $\lambda(r) = \lambda$ is constant (Mele p. 120).

Bond price and yields, eqs. (8) and (10):

$$P(r,T-t) = e^{A(T-t) - B(T-t)\,r}, \qquad
R(r,T-t) = -\frac{A(T-t)}{T-t} + \frac{B(T-t)}{T-t}\,r$$

with (Mele p. 121)

$$B(\tau,T) = \frac{1}{\kappa}\left(1 - e^{-\kappa(T-\tau)}\right), \qquad
A(\tau,T) = \big(B(\tau,T) - (T-\tau)\big)\,r_\infty - \frac{\sigma^2}{4\kappa}B^2(\tau,T)$$

$$r^* \equiv \bar r - \frac{\lambda\sigma}{\kappa}, \qquad r_\infty = r^* - \frac12\left(\frac{\sigma}{\kappa}\right)^2$$

$r_\infty$ = asymptotic (long-maturity) yield. Example (Mele p. 122): $\kappa=0.2$,
$\bar r=6\%$, $\sigma=0.03$, $\lambda=-0.015$ give $r_\infty = 5.10\%$.

Forecasting the curve (Mele p. 123, "most likely evolution in the next three months"):

$$E\big(R(r_{t_1},\tau)\mid r_{t_0}\big) = -\frac{A(\tau)}{\tau} + \frac{B(\tau)}{\tau}E(r_{t_1}\mid r_{t_0}), \qquad
\mathrm{Var}\big(R(r_{t_1},\tau)\mid r_{t_0}\big) = \left(\frac{B(\tau)}{\tau}\right)^2 \mathrm{var}(r_{t_1}\mid r_{t_0})$$

$$E(r_{t_1}\mid r_{t_0}) = \bar r + e^{-\kappa(t_1-t_0)}(r_{t_0} - \bar r), \qquad
\mathrm{var}(r_{t_1}\mid r_{t_0}) = \frac{\sigma^2}{2\kappa}\left(1 - e^{-2\kappa(t_1-t_0)}\right)$$

Mele p. 124: plot mean ± 1 s.d. "When no closed-form solutions exist for the interest
rate transition density, you may proceed through simulations."

Exact discretisation used for estimation (follows from the two moments above, step $\Delta$):
$r_{t+\Delta} = \bar r(1-e^{-\kappa\Delta}) + e^{-\kappa\Delta} r_t + \varepsilon_{t+\Delta}$,
$\varepsilon \sim N\!\big(0, \tfrac{\sigma^2}{2\kappa}(1-e^{-2\kappa\Delta})\big)$.

---

## 5. CIR (Mele pp. 118, 120, T1 slide 34)

$$dr_\tau = \kappa(\bar r - r_\tau)\,d\tau + \sigma\sqrt{r_\tau}\,dW_\tau$$

Non-negative; never reaches zero if $2\kappa\bar r \ge \sigma^2$ (Feller). Closed form when
$\lambda(r) = \ell\sqrt r$. Same exponential-affine form as (8), different $A$ and $B$.

---

## 6. Stochastic volatility: Fong and Vasicek (1991) (Mele pp. 125-134, T1 slides 36-38)

Mele eq. (11):

$$dr_\tau = \kappa_r(\bar r - r_\tau)\,d\tau + \sqrt{v_\tau}\,r_\tau^{\gamma}\,dW_{1\tau}$$
$$dv_\tau = \kappa_v(\bar v - v_\tau)\,d\tau + \xi_v\sqrt{v_\tau}\,dW_{2\tau}$$

- Closed form with $\gamma = 0$, risk premia $\lambda_r$, $\lambda_v$ both proportional to
  $\sqrt{v_\tau}$ (Mele p. 130). T1 slide 36 writes it with $dW_{1t}dW_{2t} = \rho\,dt$
  and writes the vol-of-vol as $\xi$.
- Bond price and yields (T1 slide 38), $u = T-t$, $A(0)=B(0)=C(0)=0$:

$$P(r_t,v_t,u) = e^{A(u) - B(u)r_t + C(u)v_t}, \qquad
R(r_t,v_t,u) = -\frac{A(u)}{u} + \frac{B(u)}{u}r_t - \frac{C(u)}{u}v_t$$

  $B(u)$ is the same as in Vasicek; $C(u)$ is the sensitivity to volatility, and its sign
  decides whether higher volatility lowers or raises yields. The affine form works because
  drifts, variances and the covariance are linear in $(r,v)$.
- Implications (Mele p. 133): $\lim_{T\to t} R = r_t$ for all $v_t$ and
  $\lim_{T\to\infty} R = \bar R$ (constant), so **vol moves only the middle of the curve**.
  With a large negative risk premium, a rise in $v_t$ looks like the PCA **curvature** factor.
- Example (Mele p. 134): $\gamma=0$, $\kappa_r=0.10$, $\bar r=0.05$, $\kappa_v=0.20$,
  $\bar v=0.02^2$, $\xi_v=0.025$, $\rho=0$; $\lambda_{r,\tau} = \lambda_1\sqrt{v_\tau}$,
  $\lambda_{v,\tau} = \lambda_2\sqrt{v_\tau}$ with $\lambda_1=-5$, $\lambda_2=0$;
  $\sqrt{v} \in \{0.01, 0.02, 0.03\}$ (higher vol gives a higher curve in the middle).
- Empirical motivation (Mele pp. 125-129): vol is roughly flat in the rate level except in
  the early-1980s monetary experiment and near the zero lower bound, where low rates come
  with compressed vol; the term spread anticipates vol (vol rises in recessions).
