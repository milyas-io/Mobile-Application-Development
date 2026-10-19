# Study Tracker Lab — Answers

**Name:** Muhammad Ilyas  
**Roll No:** 04072313012

## Numerical Answers

A1: 9

A2: 9

A3: 9

A4: 22

## Written Answers

**B1: Which classes are Stateless and Stateful, and why?**

LabApp, HomePage, StudentCard and GoalBanner are StatelessWidgets because they don't manage changing state. Tally, Countdown and BuggyCounter are StatefulWidgets because their values change while the app is running.

**B2: Why must the Timer be cancelled in dispose()?**

The timer must be cancelled to stop it from running after the widget is removed. Otherwise, it may try to call setState after dispose and cause an error.

**B3: Which widgets can be const, and what does const buy you?**

LabApp, HomePage, Tally, Countdown and BuggyCounter can use const constructors. Other widgets can also be const when their arguments are compile-time constants. Const helps Flutter reuse widget objects and avoids unnecessary object creation.