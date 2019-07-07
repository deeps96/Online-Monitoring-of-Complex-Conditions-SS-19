# Introduction

## Motivation

-  interesting domains: embedded applications, health, security systems of complex machines/ planes etc
-  anywhere where the correct, secure and reliable behavior is important
-  it's difficult to rate the correctness of a developed program, software is becoming more complex
  -  highly security relevant parts are required by official authorities to be checked & verified (Boing 737-Max)

## Verification Techniques

-  theorem proving
  -  mostly done manual
  -  very formal way to proof correctness of system
-  model checking
  -  automatic way of verification
  -  can be used when dealing with very small and simple systems
-  testing
  -  incomplete method to show the correctness for specific pieces of a software

-  Runtime Verification
  -  as the name already indicates - happening at runtime
  -  lightweight verification technique -> in what sense???
  -  checks a single run of a software system for a certain set of properties -> checks if they are violated or satisfied
  -  is only about detecting such violations, not reacting on them (however RV build the base to do so)

  -  RV requires a so called "monitor"
    -  "A monitor is a device that reads a finite trace and yields a certain verdict"
    -  runs in parallel to inspected software
    -  is used to check if an execution of a program (with a certain trace of events) satisfies a property formulation
    -  impartiality and anticipation are very important
      -  they guarantee that verdicts are not answered too fast (before the system can be sure) or too late (when the system could have known before for sure)
      -  requires not just true or false (wheter it satisfies a verdict) but also inconclusive (since there are situations where the system doesn't know yet)
    -  Online VS Offline
      -  Offline: works on fix set of recorded executions
      -  Online: works on a real-time stream of traces of executions in an incremental and efficient way -> monitor checks the current execution

  -  RV and Model Checking
    -  model checking checks all executions, RV checks only a the ones, that have been monitored in an actual run
    -  model checking therefor has to consider an infinite trace of events, RV only finite
    -  RV is applicable for external library code where source is unknown (black box), model checking requires knowledge about software module
    -  RV scopes on specific variables that are of interest and does not take the whole system state into account
    -  model checking takes whole system state into account
    -  "model checking suffers from so-called state explosion problem"

  -  RV and testing
    -  both do not test all possible execution paths of a system
    -  test suite is a collection of tests
    -  each test checks whether system returns expected output for a given input and a given setting
    -  "RV can be considered as passive testing"

  -  Requirements
    -  monitor should work fast and use very few resources in order to not influence the running systems that is inspected

## When to use RV

  -  when information become available only at runtime
  -  black box libraries
  -  behavior of an application depends heavily on the environment (such in adaptive, self-managing systems, where the environment can change over time)
  -  security-critical systems - double proof

## When not to use RV/ Disadvantages
  -  monitor adds overhead -> small embedded systems or software very speed is crucial forbid the use of RV
  -  only observed errors are monitored -> there is no evidence for the correctness of the whole systems

## Conclusion

--> "Online monitoring is a powerful technique that tries to accomplish an optimal trade-off between testing (incomplete) and more formal methods (often infeasible)" taken from the intro slides

intro mainly based on "A brief account of runtime verification"

# Approach

-  "Properties verified with RV are specified using any of the following approaches:
    (i) annotating the source code of the programunder scrutiny with assertions [32];
    (ii) using a high level specification language [35]; or
    (iii) using an automaton-based specificationlanguage [4, 17]"
    taken from "Testing Meets Static and Runtime Verification"

-  We are using ii -> we use run-time verification systems: MonPoly and DejaVu
-  both:
  -  use a specification document for the properties and event signatures (MonPoly single files, DejaVu combined in one file)
  -  print the violations
  -  offer a parser for the formulas

-  DejaVu:
  -  written in scala
  -  "The formulas are written in a first-order past time linear temporal logic, with the addition of macros and recursive rules" taken from DejaVu Repo
  -  QTL

-  MonPoly:
  -  written in OCaml
  -  no rules, macros
  -  MFOTL

-  Write what kind of symbols which language does understand and explain, why QTL can not be used for events happening in the future

# Use-cases

### LDCC
