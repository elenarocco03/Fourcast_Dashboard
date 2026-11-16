# tutorial3_Xiao_20261102

Source: `theory/tutorial3_Xiao_20261102.pdf` (75 pages)

> Automatic text extraction (pdftotext). Formulas are kept as plain text and may be
> flattened (fractions, sums, subscripts); check the PDF for anything that looks odd.


## Page 1

Fixed Income Securities and Credit Markets Tutorial 3
2nd Nov 2026

## Page 2

Agenda
Interest rate modeling and some practice
• Use binomial trees to price Bond or Interest rate derivative • Use binomial trees to fit already available market prices of
fixed income securities • Goal: How to price a bond or an interest rate derivative? • We are interested in determining a fair current price (say, at
time 0).
2

## Page 3

Agenda
• Part 1: Interest rate trees—general theory • Part 2: Interest rate trees—practical exercise
3

## Page 4

Part 1: Interest rate trees—theory
• We can use binomial trees to price fixed income instruments • Just like use binomial trees to price options
• What is a tree? • A tree describes a probabilistic representation: how the price develops over time using a tree-information structure.
• Example: tree • At the time of evaluation, we observe the state. In the next
period, there can be two mutually exclusive states of the world:
• The state ”up”, occurring with probability p, and the state ”down”, occurring with probability 1 − p.
• After two periods, there can be three mutually exclusive states of the world, as in the following diagram. We label the tree in this diagram a ”recombining” tree, to emphasize that the ”up & down” and the ”down & up” nodes are the same.
4

## Page 5

Part 1: Interest rate trees—theory
5

## Page 6

Part 1: Interest rate trees—theory
• Example: • We use the previous tree as a guidance to price options
written on stocks. • The stock price unfolds through the branches of the tree.
Then, we figure out no-arbitrage movements of the option price along the tree.
• Q: can we apply the same methodology and price an option written on a zero coupon bond? • The answer is NO! • We cannot “exogenously” track the bond price movements in the same way we do with a stock price. • A stock has no expiration. • Instead, after one year, a 3-year zero (say) becomes a 2-year zero, that is, a quite different security.
6

## Page 7

Part 1: Interest rate trees—theory
• Q: How to solve this issue? • price an option written on a zero coupon bond?
• A: by modeling the movements of the whole yield curve.

• There are two approaches

• Models of the Short Term Rate:

• Step 1: we model the dynamics of the short-term rate, defined

as the interest rate on a loan with maturity equal to the time

intervals in the tree.

• Step 2: we then look at the pricing implications based on this

Interest rate model .

• No arbitrage models:

• Step 1: calibration model/ no-arbitrage models— these

models describe the dynamics of the whole yield curve.

• Step 2: Take the market prices—We predict that option’s

prices are the same as the market prices.

7

## Page 8

1st Approach: Models of the Short Term Rate
8

## Page 9

Part 1: Interest rate trees—theory
Difference between models of the short-term rate and no arbitrage models:
9

## Page 10

Part 2: 1st Approach—Tree representation of the short-term rate
• We model the bond prices P in discrete time. • Short rate r is a rate on a 1-period bond. • Assume that the short rate is the only state variable and it
evolves as follows:
10

## Page 11

Part 2: 1st Approach—Bond prices depend only on one state variable

• The price of a bond with maturity T depends only on short rates r

• Theorem 1:

• There is risk-neutral probability measure ”q”, under which the probabilities of the interest rate going up and down are q and 1 − q, respectively.

P(r , T )

=

Eq[P(r˜,T )] 1+r

11

## Page 12

Part 2: 1st Approach
• Remark: risk-neutral probability measure ”q” is rather important • Case 1: q is given • Case 2: q is not given. How to find the q

• Proposition 1: when q is not given, we can compute it from p

P(r , T ) = (p − λ)P (r +, T ) + [1 − (p − λ)]P (r −, T ) = Eq[P(r˜, T )]

1+r

1+r

• where q ≡ p − λ is the risk-neutral probability.

• λ is the unit risk premium • it is the sharp ratio
12

## Page 13

Exercise 1
13

## Page 14

Part 2: 1st Approach
• Exercise 1: find the q using proposition 1
• Assume the current short-term rate equals 10%. • We know that with (physical) probability p, the short-term rate
as of the next year will increase by 2 percentage points, and with probability 1 − p, it will decrease by 2 percentage points. • Finally, with the same probability p, the short-term rate prevaling from the next year to two years time, will increase by 2 further percentage points from its previous value in one year time. • Suppose that the probability of an upward movement is 20% and that the the absolute value of the Sharpe ratio is 30%. • These data suffice to provide an estimate of the risk-neutral probability of an upward movement of the short-term rate. • We simply use the formula, q = p − λ, and obtain q = 20% − (−30%) = 50%
14

## Page 15

Exercise 2
15

## Page 16

Part 2: 1st Approach—Pricing one 2-year ZCB given q
• Exercise 2: Pricing one 2-year ZCB given q • We can set up the following tree:
16

## Page 17

Part 2: 1st Approach—Pricing one 2-year ZCB given q
• Exercise 2: Pricing one 2-year ZCB given q • Solve the tree
17

## Page 18

Part 2: 1st Approach—Pricing one 2-year ZCB given q

• Exercise 2: Pricing one 2-year ZCB given q

•

Eq[P(r˜, 2)] = qP (r +, 2) + (1 − q)P (r −, 2)

1+r

1+r

=

1 2

(0.8928)

+

1 2

(0.9259)

1.10

= 0.8267.

18

## Page 19

Part 2: 1st Approach—Pricing one ZCB with given q

• General Procedure: Backward induction • At all notes at maturity the bond is worth 1

• Price the bond 1 period before maturity using the formula from the Theorem 1

P(r , T )

=

Eq[P(r˜,T )] 1+r

• Price the bond 2 periods before maturity

• Repeat recursively until we reach t = 0

19

## Page 20

Part 2: 1st Approach—General tree pricing given q
• Previously we use the tree to price a 2-year ZCB given q. • If q is not given, we may find q using proposition 1, q ≡ p − λ
• We can simply generalize the tree to a multiperiod case. • Exercise 3: Pricing one 3-year ZCB given q
20

## Page 21

Exercise 3
21

## Page 22

Part 2: 1st Approach—General tree pricing given q
• Exercise 3: Pricing one 3-year ZCB given q
22

## Page 23

Part 2: 1st Approach—General tree pricing given q
• Exercise 3: Pricing one 3-year ZCB given q
• Solving the tree, the price of the 3 Year zero equals 0.8893 • Next, we can use this tree to price an option written on the 3
Year zero
23

## Page 24

Part 2: 1st Approach—Pricing a call option on a ZCB with a given q
• General Procedure: Pricing a European option on the 3-year ZCB
• Step 1 : Compute the values of underlying security (3-year ZCB) at any time (at any nodes) • This step is just Exercise 3.
• Step 2: Compute the payoff of the call option at the time of expiration
• Step 3: Price the option 1 period before the expiration.
• Step 4: Repeat recursively until we reach t = 0
24

## Page 25

Exercise 4
25

## Page 26

Part 2: 1st Approach—Pricing a European option on the 3Year ZCB with a given q
• Exercise 4: consider a European call option written on the 3 Year zero, with expiration date equal to 2 and strike price K = 0.95

• The model predicts that the current price of the call option is

0.0124

26

## Page 27

Summary of the 1st Approach: Models of the Short Term Rate
• Exercise 1: Find the q using proposition 1
• Exercise 2: Pricing one 2-year ZCB given q
• Exercise 3: Pricing one 3-year ZCB given q
• Exercise 4: (based on Exercise 3) Pricing a European call option written on the 3 Year zero, with expiration date equal to 2 and strike price K = 0.95, with a given q
• To sum up, 1st Approach: Models of the Short Term Rate • Assume the law driving the short rate (e.g. the tree representation of the dynamics of the short rate ) • Price bonds and derivatives
27

## Page 28

2nd Approach: No Arbitrage Models/ Calibration Approach
28

## Page 29

Part 2: 2nd Approach—No Arbitrage Models
• 2nd Approach: No Arbitrage Models/ Calibration approach • Why we need the 2nd approach • The 1st approach has drawbacks and imperfections.
• What is the problem of the 1st approach
• Using the 1st approach, Exercise 3: predicts that the price of the 3 Year zero is equal to 0.8893. (see page 22)
• However, there is no guarantee that this model-implied price equals the market price of the 3 Year zero
• Suppose, instead, that the market price of the 3 Year zero, P$ say, equals 0.8700.
• What should we do to make the model-implied price of the 3 Year zero equal to the market price of the 3 Year zero?
29

## Page 30

Part 2: 2nd Approach—No Arbitrage Models
• To make the model-implied price of the 3-year ZCB (which is 0.8893) equal to the market price, P$ = 0.8700.
• We can not take the risk-neutral probability q as given.
• Here, we take the Price at time 0 as known. • In this case, the price at time 0 is the market price P$ = 0.8700.
• And we take the q as unknown.
• We should calibrate the probability q
30

## Page 31

Exercise 3.1
31

## Page 32

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 3.1: Fitting q to correctly price a 3-year ZCB • Our goal is to find the correct q
• Assume that the probability of the short rate going up is constant across time and state space: always q (which is still unknown)
• At all nodes at maturity the bond is worth 1. • Price the bond 1 period before maturity (t = 2). • Price the bond 2 periods before maturity: obtain a formula
that involves the unknown q in each node (t = 1) • Price the bond at t = 0: obtain a formula that involves the
unknown q • Let this formula equals to the given market price and we solve
for the correct q
32

## Page 33

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 3.1 : Fitting q to correctly price a 3-year ZCB
33

## Page 34

Part 2: 2nd Approach—No Arbitrage Models

• Exercise 3.1: Fitting q to correctly price a 3-year ZCB

• q · 0.9433 + (1 − q) · 0.9615 P1(5%) = 1.05 q · 0.9615 + (1 − q) · 0.9804 P1(3%) = 1.03

•
P$ = 0.8700 =

1 (︃ q · 0.9433 + (1 − q) · 0.9615

q · 0.9615 + (1 − q) · 0.9804 )︃

q·

+ (1 − q) ·

1.04

1.05

1.03

• This is a nonlinear equation in q, that we can easily solve with a computer to obtain the correct q (a.k.a fitted q),
q = 0.8779
34

## Page 35

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 3.1: Fitting q to correctly price a 3-year ZCB

• This diagram depicts the implied binomial tree.

35

## Page 36

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 3.1: Fitting q to correctly price a 3-year ZCB • In the implied tree, q = 0.8779, which is correct. • We finally correctly price a 3-year ZCB at any time (at any nodes).
• This implied binomial tree is useful: • We could use this (correct) implied bionomial tree to correctly price the European call option written on the 3-year ZCB. (Exercise 4 )
• Let’s do the computations by utilizing the implied binomial tree.
• Exercise 4.1: Pricing a call option written on the 3-year ZCB with the fitted q
36

## Page 37

Exercise 4.1
37

## Page 38

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 4.1: Pricing a call option written on the 3-year ZCB with the fitted q
• Recall how to solve for the call option • Step 1 : Compute the correct values of underlying security (3-year ZCB) at any time (at any nodes)
• This step is just Exercise 3.1
• Step 2: Compute the payoff of the call option at the time of expiration
• Step 3: Price the option 1 period before the expiration.
• Step 4: Repeat recursively until we reach t = 0
38

## Page 39

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 4.1: Pricing a call option written on the 3-year ZCB with the fitted q
• Based on the implied binomial tree from Exercise 3.1
39

## Page 40

Part 2: 2nd Approach—No Arbitrage Models
• Exercise 4.1: Pricing a call option written on the 3-year ZCB with the fitted q
• Final result:
• Exercise 4.1: Current price of the call option is 0.0026.
40
• Exercise 4: Current price of the call option is 0.0124.

## Page 41

Part 2: Summary of the 1st Approach and 2nd Approach
• Exercise 1: Find the q using proposition 1
• Exercise 2: Pricing one 2-year ZCB given q
• Exercise 3: Pricing one 3-year ZCB given q
• Exercise 4: (based on Exercise 3) Pricing a European call option written on the 3 Year zero, with expiration date equal to 2 and strike price K = 0.95, with a given q
• Exercise 3.1: Fitting q to correctly price a 3-year ZCB
• Exercise 4.1: (based on Exercise 3.1) correctly Pricing a call option written on the 3-year ZCB with the fitted q
41

## Page 42

Part 2: We cannot apply the same q to the pricing of different bonds
• We are not done. What are the remaining problems? • Let us go back to the Exercise 2: Pricing a 2-year ZCB
• Suppose right now we have the Exercise 2.1: we want to correctly Pricing a 2-year ZCB. This means we need to find the corresponding (fitted) q
• In Exercise 3.1:, we have found the fitted q = 0.8779 which is suitable for correctly pricing a 3-year ZCB and the call option written on it.
• The question is: can we directly apply this fitted q = 0.8779 to correctly price 2-year ZCB and the call option written on it.
• The answer is, of course, NO. • There are no reasons for which the inputs utilized to fit the
price of the 3 Year zero could also lead to fit the price of the 2 Year zero • The 2-year ZCB is quite a different asset from the 3-year ZCB! 42

## Page 43

A Wrong Exercise
43

## Page 44

Part 2: We cannot apply the same q to the pricing of different bonds
• A Wrong Exercise: • we observe the market price of a 2-year ZCB equals 0.9200.
• we use the fitted q = 0.8779 (derived from the pricing of 3-year ZCB) to price 2-year ZCB
• We find that the price of the 2-year ZCB implied by the price of the 3-year ZCB is equal to 0.9178. (which is wrong, for it does not equal to the market price of 2-year ZCB which is 0.9200 )
• we cannot simultaneously fit the price of the 3-year and the 2-year zeros with the same risk—neutral probability, q = 0.8779
44

## Page 45

Part 2: We cannot apply the same q to the pricing of different bonds
• A Wrong Exercise: Tree and calculation details
45

## Page 46

Part 2: solution
• To simultaneously fit the price of the different kinds of ZCB (with different maturity), we should make the risk-neutral probabilities q time-varying.
46

## Page 47

Exercise 5
47

## Page 48

Part 2: implement implied binomial tree in a more general case
• Exercise 5: price a 0.5-year ZCB and 1-year ZCB without knowing the q • But we know the market price of the 1-year ZCB, which is 0.95974
• The basic setup is: • Suppose the time interval is six months, so that the short-term rate is for six months. • The current short-term rate is 3.99%, annualized. ’ • It can change to either 4.50% or to 4.00%,
• Goal: What is the risk-neutral probability q implied by this tree? This probability must be such that, the price of all the 48

## Page 49

Part 2: Exercise 5

• Let us first focus on the 0.5-year ZCB (6M ZCB)

• Naturally, the market price of a 6-month ZCB at t = 0 must

equals

(︃ 0.0399 )︃

P$(0, 0.5) = 1/ 1 + 2

= 0.9804

• The current short-term rate, 3.99%, is a mere definition. • It is independent of the value of risk-neutral probability q • Next we focus on the 1-year ZCB

• Recall that we know the market price of the 1-year ZCB, which

is 0.95974.

• Hence we can solve for the risk-neutral probability.

• The risk-neutral probability satisfies:

1

P$(0, 1)

=

0.95974

=

1+

0.0399 2

[q

· 0.9779

+ (1 −

q) · 0.9804]

• yielding q = 0.605.

49

## Page 50

Part 2: Exercise 5
50

## Page 51

Exercise 6
51

## Page 52

Part 2: Exercise 6
• Exercise 6: based on Exercise 5, price a call option written on the 1-year ZCB, with expiration date in six months and exercise price equal to K = 0.9785

• So the option price is, by risk-neutral evaluation

1

C

=

1+

0.0399 2

[q · 0 + (1 − q) · 0.0019]

= 0.9804 · [0.395 · 0.0019] = 7.3579 × 10−4

52

## Page 53

More complex situation based on exercise 5
• Exercise 7: three types of ZCB without knowing q • Now, we have three periods. The time interval is 0.5 year (6M). • We know the dynamics of the interest rate.
• Three ZCB: 0.5-y, 1-y, 1.5-y • We know the market prices are: 0.9804, 0.95974, 0.9382
53

## Page 54

Exercise 7
54

## Page 55

Exercise 7
• Exercise 7: three types of ZCB without knowing q • Goal: find q0 and q1.

• Again, focus on 1-yr ZCB to find q0. (same with page 47) • Recall that we know the market price of the 1-year ZCB, which is 0.95974. • Hence we can solve for the risk-neutral probability q0. • The risk-neutral probability q0 satisfies:

1

P$(0, 1)

=

0.95974

=

1

+

0.0399 2

[q0

· 0.9779 + (1 − q0) · 0.9804]

• yielding q0 = 0.605.

55

## Page 56

Exercise 7

• Exercise 7: three types of ZCB without knowing q

• Focus on 1.5 yr ZCB to find q1 • Recall that we know the market price of the 1.5 year ZCB,

which is 0.9382.

• Also knowing q0 = 0.605. • Hence we can solve for the risk-neutral probability q1. • The risk-neutral probability q1 satisfies:

1

Pu(0.5, 1.5)

=

1+

0.045 2

[q10.9761 + (1 −

q1) 0.9789]

1

Pd (0.5, 1.5)

=

1+

0.040 2

[q10.9789 + (1 −

q1) 0.9808]

1

P$(0, 1.5)

=

0.9382

=

1

+

0.0399 2

[q0Pu(0.5, 1.5) +

(1 −

q0) Pd (0.5, 1.5

• one equation with one unknown, solved by q1 = 0.8412

56

## Page 57

Exercise 7
57

## Page 58

Exercise 8
58

## Page 59

Exercise 8
• Exercise 8: based on Exercise 7, price a call option on the 1.5-year zero, which expires in one year and has exercise price equal to 0.9800
59

## Page 60

Exercise 8

• Exercise 8: based on Exercise 7, price a call option on the 1.5-year zero, which expires in one year and has exercise price equal to 0.9800

• This figure summarizes the calculations. The no-arbitrage

price of the option is:

1

C

=

1+

0.039 2

[q0

·

0 + (1

− q0)

· 0.0020]

=

0.9804[0.395·0.0020]

=

7.745×

60

## Page 61

Summary: Fitting many ZCB
• Exercise 5: price a 0.5-year ZCB and 1-year ZCB without knowing the q • But we know the market price of the 1-year ZCB, which is 0.95974
• Exercise 6: based on Exercise 5, price a call option written on the 1-year ZCB, with expiration date in six months and exercise price equal to K = 0.9785
• Exercise 7: three types of ZCB without knowing q • Three ZCB: 0.5-y, 1-y, 1.5-y • We know the market prices are: 0.9804, 0.95974, 0.9382
• Exercise 8: based on Exercise 7, price a call option on the 1.5-year zero, which expires in one year and has exercise price
61
equal to 0.9800

## Page 62

Summary
• Practice pricing in risk-neutral framework in discrete time • Keep in mind general classes of models in this course:
• Interest rate models: assume the law/dynamics driving the short rate
• Price bonds and derivatives
62

## Page 63

Exercise 9
Exercise 9 illustrates how information on derivative data may exploited to predict the price of the underlying assets.
63

## Page 64

Additional Exercise

• We use derivative (say, call option) data on zero coupon bonds and calibrate risk-neutral probabilities that we use for the purpose of bond evaluation.

• In particular, we know the price of 2-year ZCB and the price of

a European call option written on a 3-year zero coupon bond.

• And we use these data to find the no-arbitrage price of a

3-year coupon bearing bond that pays off 3% of the principal

of $1 every year.

• Precisely, we use the price of the 2-year zero and recover the

risk-neutral probability q0 applying to the first year • Then, we recover the risk-neutral probability applying to the

second year q1 from the option price • With these probabilities, we determine the no-arbitrage price

of the 3-year coupon bearing bond that pays off 3% of

the principal of $1 every year.

64

## Page 65

Exercise 9
• The interests dynamics is given: the short-term rate evolves over time according to the tree
65

## Page 66

Exercise 9
• What we know:
• There is a 2-year ZCB traded at the market price equal to P$(0, 2) = 0.95500.
• There is a European call option written on a 3-year zero coupon bond. This option has a strike price equal to 0.97000, expires in two years, and quotes for C$(0, 2) = 1.0141 · 10−3.
• Step 1: Let us focus on the market price of 2-year ZCB.
• we use the price of the 2-year zero and recover the risk-neutral probability q0 applying to the first year.
• we know that P$(0, 2) = 0.95500.
66

## Page 67

Exercise 9
67

## Page 68

Exercise 9

• Step 1: We can then solve for the risk-neutral probability q0 applying to the first year (or, say, from time 0 to time 1)

P8(0, 2) = 0.95500
1 = 1.02 (q0 · Pu(1, 2) + (1 − q0) Pd (1, 2))
1 = 1.02 (q0 · 0.97087 + (1 − q0) 0.98039) .

• That is,

q0 = 0.6607

68

## Page 69

Exercise 9
• Step 2: We then solve for the risk-neutral probability q1 applying to the second year (or, say, from time 1 to time 2) • We already know q0 = 0.6607 • We know the price of the call option written on a 3-year zcb, C$(0, 2) = 1.0141 · 10−3. • the option strike is K = 0.97000.
69

## Page 70

Exercise 9
70

## Page 71

Exercise 9
• Step 2: The option price at t = 1 can be either Cu or Cd , where
1 Cu = 1.03 [q1 max {Puu(2, 3) − K , 0} + (1 − q1) max {Pud (2, 3) − K , 0}]
1 = 1.03 (1 − q1) 0.00087
1 Cd = 1.02 [q1 max {Pud (2, 3) − K , 0} + (1 − q1) max {Pdd (2, 3) − K , 0}]
1 = 1.02 [q10.00087 + (1 − q1) 0.01039]
• The option price satisfies C$(0, 2) = 1.0141 · 10−3 1 = 1.02 (q0Cu + (1 − q0) Cd ) 1 = 1.02 (0.6607Cu + 0.3393Cd )
71

## Page 72

Exercise 9
• Step 2: Replacing the previous expressions for Cu and Cd into this equation leaves an equation for q1, which is solved by
q1 = 0.8000 • Step 3: Next, we determine the price of a 3-year ZCB
maturing at t = 3, P(0, 3), that is embedded in the market prices, P$(0, 2) and C$(0, 2).
1 Pu(1, 3) = 1.03 [q1Puu(2, 3) + (1 − q1) Pud (2, 3)]
= 1 (0.80 · 0.96618 + 0.20 · 0.97087) = 0.93895. 1.03 1
Pd (1, 3) = 1.02 [q1Pud (2, 3) + (1 − q1) Pdd (2, 3)] = 1 (0.80 · 0.97087 + 0.20 · 0.98039) = 0.95370. 1.02 1
P(0, 3) = 1.02 [q0Pu(1, 3) + (1 − q0) Pd (1, 3)] 1
= (0.6607 · 0.93895 + 0.3393 · 0.95370) = 0.92545 1.02 72

## Page 73

Exercise 9
• Step 4: Recall our goal is to price the 3-year coupon bearing bond that pays off 3% of the principal of $1 every year. • Not the 3-year ZCB
• Finally, the price of the 3-year bond bearing a 3%-coupon is B(0, 3) = 0.03 · [P$(0, 1) + P$(0, 2) + P(0, 3)] + P(0, 3) = 0.03 · (0.98039 + 0.95500 + 0.92545) + 0.92545 = 1.0113
73

## Page 74

Exercise 9
• To sum up, Exercise 9 implies: • We can use the price of 2-year ZCB and the price of a European call option written on a 3-year zero coupon bond as the input to find the no-arbitrage price of a 3-year coupon bearing bond that pays off 3% of the principal of $1 every year.
74

## Page 75

Recap so far
• 1st Approach: Models of the Short Term Rate • 2nd Approach: No Arbitrage Models/Calibration Approach
Logic of each approach Difference of two approach What is the input, output?
75
