# Tutorial1_Xiao_2026_10_05

Source: `theory/Tutorial1_Xiao_2026_10_05.pdf` (56 pages)

> Automatic text extraction (pdftotext). Formulas are kept as plain text and may be
> flattened (fractions, sums, subscripts); check the PDF for anything that looks odd.


## Page 1

Tutorial 1
Shuxiao Zhou 5 October 2026

## Page 2

Today’s Agenda
From stochastic processes to bond prices 1. A brief review of bonds and interest rates. 2. Stochastic processes and Itˆo’s lemma. 3. Vasicek and CIR. 4. Stochastic volatility. 5. Change of measure.
2

## Page 3

A brief review of bonds and interest rates

## Page 4

Bonds, Zeros and Spot Rates

A coupon bond pays coupons Cti at dates t1, . . . , tn = T and principal of one at T . Its price is B(t, T ).

A zero-coupon bond pays one at T . Its price is P(t, T ).

At time zero, write P(T ) = P(0, T ). The annually compounded spot rate r (T )

satisfies

1 P(T ) = [1 + r (T )]T .

4

## Page 5

Discounting Future Cash Flows

The continuously compounded spot rate is

1 R(T ) = − log P(T ),
T

P(T ) = e−R(T )T .

A coupon bond is a portfolio of zero-coupon bonds. No arbitrage gives

n
∑︂ B(T ) = Cti P(ti ) + P(T ).
i =1

Each cash flow uses the discount factor for its own payment date.

5

## Page 6

Bond Prices and Interest Rates

Bond price

1

0.9

0.8

0.7

0.6

0.5

0.4

0.3 0

0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09

0.1

YTM

Bond prices fall as the yield rises. Duration gives a local first-order approximation. Convexity adds a second-order correction. We now study how interest rates themselves evolve over time.

Figure 2. The bond price-yield relation (solid line), its ﬁrst-order approximation (duration) and its second-order approximation (convexity).
6

## Page 7

Stochastic processes and Itˆo’s lemma

## Page 8

Stochastic Processes
• A stochastic process is a collection of random variables indexed by time {X (t) : t ∈ T } (or simply Xt )
• Example: Stock prices are usually modelled as real-valued processes in continuous- or discrete-time
8

## Page 9

Stochastic Processes: Example
9

## Page 10

Random Walk

• Let Yt be independent discrete random variables such that
⎧ ⎨+1 with probability 1/2 Yt = ⎩−1 with probability 1/2

• The random walk is the discrete-time stochastic process:

X0 := 0

and

Xt

:=

∑︁t
i =1

Yi

for

t >0

10

## Page 11

History of Brownian Motion/Wiener Process
• A Brownian motion is the random motion of particles in a fluid, resulting from their collision with other molecules
• The botanist Robert Brown first described it in 1827 looking through a microscope at pollen immersed in water
11

## Page 12

History of Brownian Motion/Wiener Process
• A Wiener process is a continuous-time stochastic process named in honor of American mathematician Norbert Wiener
• Often called Brownian motion for historical connection with the physical process observed by botanist Robert Brown
• Applications in pure and applied mathematics, economics, quantitative finance, evolutionary biology, and physics
12

## Page 13

Brownian Motion/Wiener Process: Formal Definition
The Wiener process is a real-valued, continuous-time stochastic process W with continuous sample paths and the following properties - W0 = W (0) = 0
√ - Increments on ∆t are ∆W := ε ∆t with ε ∼ N(0, 1) - Increments on any two disjoint intervals are independent
13

## Page 14

Brownian Motion/Wiener Process: Formal Definition
• Gaussian increments: If s, t ≥ 0 then W (s + t) − W (s) is normal with variance t.
• Intuition: Wt accumulates independent normal increments across time. Over an interval of length ∆t, each increment has variance ∆t.
14

## Page 15

Brownian Motion/Wiener Process: Property
• W (0) = 0 E(W (t)) = 0 Et(W (t + ∆t)) = W (t)
• the BM is a Markov process: only the last realization is relevant to make a probabilistic statement concerning the future behavior
• the BM is a martingale: the best forecast of the future is today’s value
15

## Page 16

Brownian Motion/Wiener Process: Property

• The change in BM .

∆Wt = Wt+∆t − Wt ∼ N(0, ∆t)

From the definition, for ∆Wt

E [∆Wt ] = 0 Var [∆Wt] = ∆t

√so the variance has the same size as the time interval: the standard deviation is ∆t, rather than ∆t

16

## Page 17

Brownian Motion/Wiener Process: Property

• and for (∆Wt )2

E

[︂ (∆Wt

)2]︂

=

∆t

Var

[︂ (∆Wt

)2]︂

=

2(∆t )2

the variance of the squared increment is of order (∆t)2. Over a fine partition, the sum of squared increments converges to elapsed time

• In some limit, we will show that as ∆t → dt, (dWt)2 can be treated as being equal to dt!

(This is so-called quadratic variation)

17

## Page 18

Ito Stochastic Integral

• The Ito Stochastic Integral is a stochastic process Yt

ˆt
Yt = Hs dWs
0

ˆt (or H(s)dW (s) )
0

where Ws is a Wiener process and Hs is a well-behaved stochastic process

• An important condition is that H is an adapted process

Loosely speaking this means that H(s) is known at time s given the information available then; it cannot depend on future price changes

18

## Page 19

Ito Stochastic Integral: Application in finance
• tracking the cumulative gains of an investment strategy over time ˆt
V (t) = H(s)dW (s)
0
• The integrand H(s) is the number of shares held at time s • The integrator dW (s) is the price movement at time s • The integral is the cumulative trading gain in dollars at time t • The requirement that H is adapted means that holdings should be chosen before
observing the next change in prices
19

## Page 20

Generalized Wiener Processes/ Brown Motion
• A generalized Wiener process has the form dX = adt + bdW , a, b ∈ R
The deterministic component adt is called the drift The stochastic component bdW is called the diffusion
20

## Page 21

Generalized Wiener Processes/ Brown Motion: Ito Process

An Ito process is a continuous-time process Xt such that dX = a (Xt , t) dt + b (Xt , t) dWt
where a(X , t) and b(X , t) are deterministic functions

Alternatively, it can be defined using the integral form

ˆt

ˆt

Xt = X0 + a (Xs , s) ds + b (Xs , s) dWs

0

0

Assumption: the process is adapted,
i.e. the process uses only information available at the current time
21

## Page 22

Ito Process: Example
Consider the following Ito process dX = a (Xt , t) dt + b (Xt , t) dWt
with a(X , t) = 0.005 and b(X , t) = 1 + cos(2t)
The time-varying b(X , t) induces time-varying volatility
22

## Page 23

How to Model Stock Price (Level)
At a first glance, a good model for the price S of a stock could be based on a simple generalized Wiener process
dS = µdt + σdW where the parameters µ, σ ∈ R represent, respectively, the expected profit and volatility of the stock price
However, it is easy to realize that such a model would be far from realistic
In the real world, investors require a percentage expected profit, independent of the price level
Also, volatility should not depend on the price level and rather expressed in percentage terms
23

## Page 24

More Realistic Model of Stock Price (Percentage/Return)
A more suitable candidate to model the price of a stock is given by the following Ito process
dS = µSdt + σSdW
Or, to express it explicitly in percentage terms, we can write dS = µdt + σdW S
the returns process is a generalized Wiener process Now the parameters µ and σ have a clear meaning: µ is the percentage expected return on the stock σ is the stock return volatility
24

## Page 25

Ito’s Lemma

Lemma (Ito’s Lemma)

Let X be the Ito process defined by

dX = a(X , t)dt + b(X , t)dW

and f = f (X , t) a sufficiently smooth deterministic function of X and time. Then

(︃ ∂f ∂f b2 ∂2f )︃

∂f

df =

∂t

+a ∂X

+

2

∂X 2

dt + b dW ∂X

Ito’s Lemma gives a formula for the first-order increment of f
It is the stochastic version of the change of variable formula
25

## Page 26

Example using Ito’s Lemma: Log Stock Prices

dS = µdt + σdW
S

Let G (S) = ln(S). Partial derivatives are

∂G 1 ∂2G

1 ∂G

=, ∂S S

∂S2 = −S2 ,

=0 ∂t

Hence Ito’s lemma gives

(︃ σ2 )︃ dG = µ − dt + σdW
2

26

## Page 27

Example using Ito’s Lemma

F (Wt , t) = 3 + t + eWt

Using

Ito,

we

derive:

dFt

=

[︁1 +

1 2

e

Wt

]︁

dt

+ eWt dWt

27

## Page 28

Additional Exercise 1: Squared Brownian Motion

Let Wt be standard Brownian motion and f (Wt) = Wt2.

1. Compute fW and fWW .

2.

Apply

Itoˆ’s

lemma

to

obtain ˆt

d

(Wt2).

3. Deduce an expression for Ws dWs .

0

Compare your result with the ordinary chain rule.

28

## Page 29

Additional Exercise 2: An Exponential Martingale

Let θ be constant and define

Zt

=

exp

(︁θWt

−

1 2

θ2t

)︁

.

1. Compute ft , fW and fWW . 2. Apply Itoˆ’s lemma to obtain dZt. 3. Verify E [Zt] = 1 using the normal moment-generating function.

29

## Page 30

Additional Exercise 3: Powers of Stock Prices

Suppose S0 > 0 and For F (S) = Sp:

dSt = µSt dt + σSt dWt .

1. Compute FS and FSS . 2. Obtain the drift and diffusion of F (St). 3. Check the result for p = 1 and p = 2.

30

## Page 31

Short Rates and Bond Prices

A zero-coupon bond pays one at maturity: P = P(r , t, T ), with P(r , T , T ) = 1.

The short rate follows

dr = b(r , t) dt + a(r , t) dW .

Here b is the drift and a the diffusion coefficient: the reverse of the Part 2 notation.

No arbitrage: for a bond with dP/P = µP dt + σP dW ,

µP − r = λ σP .

Combined with Itˆo’s lemma, this gives the pricing equation

Pt

+

(b

−

aλ)Pr

+

1 2

a2Prr

−

rP

=

0,

P(r , T , T ) = 1.

31

## Page 32

Vasicek and CIR

## Page 33

Vasicek: Model
drt = κ(r¯ − rt) dt + σ dWt, κ > 0, σ > 0, r¯ ∈ R. • Mean-reverting drift, constant diffusion coefficient. • Constant market price of risk λ.
33

## Page 34

CIR: Model

√ drt = κ(r¯ − rt ) dt + σ rt dWt ,

r0 ≥ 0, κ, r¯, σ > 0.

• The process stays nonnegative; if r0 > 0 and 2κr¯ ≥ σ2, zero is never reached. √
• Market price of risk λ(r ) = ℓ r .

34

## Page 35

Stochastic volatility

## Page 36

Stochastic Volatility in Interest Rate Models

In Vasicek and CIR, volatility is constant or a function of rt: the same rate level always means the same volatility.

Empirical evidence suggests that volatility has its own dynamics. A separate factor allows different volatility at the same interest-rate level.

Example: Fong and Vasicek (1991) model
√ drt = κr (r¯ − rt )dt + vt dW1t ,
√ dvt = κv (v¯ − vt )dt + ξ vt dW2t ,

dW1t dW2t = ρ dt.

rt mean-reverts as in Vasicek, but its variance vt is random. vt follows a CIR process, so it stays nonnegative.

36

## Page 37

Stochastic Volatility: The Level Effect °c 2006-2026 by Antonio Mele • Level eﬀect?

Basis Point volatility

Sample size: 1957:01 - 2008:12 600

500

400

300

200

100

0

0

5

10

15

20

Short-term rate

Sample size: 1957:01 - 2008:12 150

100

50

0

0

5

10

15

20

Short-term rate

Log volatility

Basis Point volatility

Sample size: 1990:01 - 2008:12 200

150

100

50

0

0

2

4

6

8

Short-term rate

Sample size: 1990:01 - 2008:12 120

100

80

60

40

20

0

0

2

4

6

8

Short-term rate

Log volatility

The relation between the rate level and volatility differs across sample periods.

Chapter II - Foundational issues on interest rate modeling

128
37

## Page 38

Implications of Stochastic Volatility

Bond prices and yields depend on both rt and vt:

P (rt , vt , u) = eA(u)−B(u)rt +C (u)vt ,

u = T − t,

A(0) = B(0) = C (0) = 0.

A(u) B(u) C (u) R(rt , vt , u) = − u + u rt − u vt . The affine form works because the drifts, the variances and the covariance are all linear in (r , v ).

B(u) has the same form as in Vasicek. C (u) captures sensitivity to the volatility factor: its sign decides whether higher volatility lowers or raises yields.

38

## Page 39

Change of measure

## Page 40

Change of Measure – Example
Recall the example of Ω = {↘, −→, ↗}, with A1 = {↘} A2 = {−→} A3 = {↗}
and probability measure P defined by P (A1) = 0.5 P (A2) = 0.25 P (A3) = 0.25
Consider the random variable M : Ω → R such that M (A1) = 0.5 M (A2) = 1 M (A3) = 2
Clearly M ≥ 0 and EP [M] = 1
40

## Page 41

Change of Measure – Example
The change of measure gives rise to the following Q Q (A1) = EP [1A1M] = P (A1) M (A1) = 0.25 Q (A2) = EP [1A2M] = P (A2) M (A2) = 0.25 Q (A3) = EP [1A3M] = P (A3) M (A3) = 0.5
41

## Page 42

Radon-Nikodym Theorem
42

## Page 43

Radon-Nikodym Theorem
Let P, Q be probability measures on (Ω, A) such that P(A) = 0 ⇐⇒ Q(A) = 0
for any subset A ∈ A. Then there exist a unique random variable M ≥ 0 with E[M] = 1 such that
Q(A) = EP [M1A]
M is called the Radon-Nikodym derivative, denoted as dQ
M= dP
In the previous example, we could use M (Ai ) = Q (Ai ) /P (Ai )
43

## Page 44

Change of Measure and Random Variables
44

## Page 45

Change of Measure and Random Variables
Recall that, given a probability triple (Ω, F, P), the distribution of a random variable X : Ω → R can be induced by P using the push-forward
Naturally, when we move from P to another probability measure Q, the implied distribution of X also changes
X ∼P fXP −→ X ∼Q fXQ
In the previous example, we looked at a variable X representing the payoff of a derivative such that
X (↘) = 0 X (−→) = 0 X (↗) = 100
45

## Page 46

Change of Measure and Random Variables

The distribution of X changes in the following way

Under the original P we had

{︄

X =P 0

with probability 0.75

100 with probability 0.25

Under the new Q we have instead

{︄

X =Q 0

with probability 0.5

100 with probability 0.5

As a consequence, the expected value also changes EP [X ] = 25 and EQ [X ] = 50
46

## Page 47

Girsanov’s Theorem and Risk-Neutral Measure
47

## Page 48

Girsanov’s Theorem

Let Wt process

bsuecBh rtohwantiaEn[︂eMxopt(i︂o12n´o0Tn

a probability triple (Ω, F, P) and let Yt be an )︂]︂
Ys2ds < ∞ (Novikov Sufficiency Condition).

adapted

Then there exists a probability measure Q defined by

dQ dP

=

(︃ ˆ T exp −
0

Yt dWt

−

1 2

ˆT
0

)︃ Yt2dt

such that Q(A) = 0 ⇐⇒ P(A) = 0 and the process ˆt
W˜t := Wt + Ys ds
0
is a Brownian motion under Q

48

## Page 49

Risk-Neutral Measure
- In asset pricing, changing the probability measure is key - Change from the historical (or physical) probability P to the risk-neutral probability Q - P is the observed probability distribution of returns, estimated from historical data - Q is an artificial (or synthetic) probability distribution, such that all assets have expected return equal to the risk-free rate - The fundamental theorem of asset pricing states that such a Q exists only if the market is efficient - The random variable M > 0 associated to the change of measure is called stochastic discount factor - In practice, Q over-weights the probability of bad states
49

## Page 50

Risk-Neutral Measure – Discrete-time Example
Consider a stock with price S0 = 95 and possible prices after one year ⎧ ⎨110 with prob. 50%
ST = ⎩90 with prob. 50%
The expected return is µ ∼= 5.25%, volatility σ ∼= 10.5% Assuming r = 1%, the Sharpe ratio is
SR = µ − r ∼= 0.4 σ
50

## Page 51

Risk-Neutral Measure – Discrete-time Example

The expected price as a function of a new probability q is
EQ [st ] = q · 110 + (1 − q)90 = 20q + 90

We find q equating the expected return to the risk-free rate

µ = Ea [sr ] − 1 = 20q − 5 = r =⇒ q =∼ 30%

s0

95

51

## Page 52

Risk-Neutral Measure – Discrete-time Example
The distribution of future stock prices under Q is ⎧ ⎨110 with prob. 30%
ST = ⎩90 with prob. 70%
Notice the shift of ∆ = 20% in the probabilities Interestingly, the Sharpe ratio is SR = 40% and the original q = 50%. is it a coincidence that SR × q = ∆ ?
52

## Page 53

Mechanics of change of numeraire / measrue
53

## Page 54

Mechanics of change of numeraire
• Choice of a numeraire is a matter of convenience and is dictated by the valuation problem at hand.
• Asset valuation leads frequently to complicated stochastic processes, and one way of making the problem easier is to eliminate the drift term from the stochastic differential equation defining the process.
• The change of numeraire technique allows us to achieve precisely this: modify the probability law (the measure) of the process so that, under this new measure, the process is drift-less, i.e. it is a martingale.
54

## Page 55

Additional Exercises: Solutions

Exercise 1 d (Wt2) = dt + 2Wt dWt ,

ˆt

Ws

dWs

=

1 2

(Wt2

− t).

0

Exercise 2

dZt = θZt dWt ,

E [Zt ] = e−θ2t/2eθ2t/2 = 1.

For constant θ, the exponential process is a true martingale.

## Page 56

Exercise Solutions: Powers of Stock Prices

For F (S) = Sp, Itˆo’s lemma gives

FS = pS p−1,

FSS = p(p − 1)S p−2.

d (Stp)

=

Stp

[︁pµ

+

1 2

p(p

−

1)σ2]︁

dt

+

pσStp

dWt .

For p = 2,

d (St2) = (2µ + σ2)St2dt + 2σSt2dWt .
