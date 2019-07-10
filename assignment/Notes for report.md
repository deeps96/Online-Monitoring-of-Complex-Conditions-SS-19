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
  -  MFOTL (metric first-order temporal logic)

-  Write what kind of symbols which language does understand and explain, why QTL can not be used for events happening in the future

# Use-cases

## LDCC

-  Nokia Data-collection campaign
-  real world data collection
-  "The campaign collected data from mobile phones of 180 participants
    and propagated it through three databases db1, db2, and db3. The phones uploaded their
    data directly to db1, while a synchronization script script1 periodically copied the data
    from db1 to db2. Then, database triggers on db2 anonymized and copied the data to
    db3. The participants could query and delete their own data in db1 and such deletions
    were propagated to all databases" https://people.inf.ethz.ch/trayteld/papers/rv18-som/som.pdf
-  ran from 2009-2011, published during the Mobile Data Challenge in 2011 https://www.idiap.ch/dataset/mdc
-  data available for non-profit organizations
-  Data deletion/propagation is done by scripts. (assignment.pdf)
-  huge dataset: 28.2 GB uncompressed with 218,714,631 events
-  https://www.idiap.ch/~gatica/publications/KiukkonenBlomDousseGaticaLaurila-icps10.pdf

### event types

-  9 event types:
  -  insert	214134597
  -  update	698698
  -  delete	938
  -  script_start	658
  -  script_end	656
  -  script_md5	555
  -  commit	550
  -  script_svn	370

examples: (write attribute name, attribute type and example attribute value for each)

d	db	md5	p	rev	rev1	rev2	s	status	tp	ts	u	url
type													
insert	112151559\n	db1	NaN	[unknown]	NaN	NaN	NaN	NaN	NaN	30	1275324590	[unknown]	NaN
select	[unknown]\n	db3	NaN	[unknown]	NaN	NaN	NaN	NaN	NaN	65	1277196513	user1	NaN
update	[unknown]\n	db2	NaN	[unknown]	NaN	NaN	NaN	NaN	NaN	16307	1277216945	script	NaN
delete	[unknown]\n	db3	NaN	[unknown]	NaN	NaN	NaN	NaN	NaN	82980	1277728781	user7	NaN
script_start	NaN	NaN	NaN	NaN	NaN	NaN	NaN	script1\n	NaN	346	1277200697	NaN	NaN
script_end	NaN	NaN	NaN	NaN	NaN	NaN	NaN	script1\n	NaN	31179	1277232759	NaN	NaN
script_md5	NaN	NaN	ac6d06f21af087dcc171a82738b3af42\n	NaN	NaN	NaN	NaN	script1	NaN	1844086	1290211214	NaN	NaN
commit	NaN	NaN	NaN	NaN	1\n	NaN	NaN	NaN	NaN	0	1272882926	NaN	url1
script_svn	NaN	NaN	NaN	NaN	NaN	224	224\n	script12	svn-latest	1844085	1290211209	NaN	url171

### detailed data anlysis

actions per database:

  id	count
1	db3	110800024
0	db2	107549456
2	db1	361953
3	None	3198

number of p values: 215
  various numbers, also including [unknown]
number of u values: 62
  script, triggers, user1 ... user58, [unknown], None
number of scripts: 4
  id	count
  3	None	218711983
  0	script12	888
  1	script11	888
  2	script1	872
number of d values: 107316152
  various numbers, including [unkown] and None

### TODO conditions, property formulation, results, short summary/ description of results, performance analysis

#### conditions
-  3 conditions to test... (however only the first one can be done with DejaVu)
-  script2 Only the script script2 may delete data in db2
-  insert Data uploaded by the phone into db1 must be inserted into db2 within 30 hours after the upload, unless it has been deleted from db1 in the meantime.
-  delete Data may be deleted from db3 iff it has been deleted from db2 within the last minute.

## Smart Medical Environment

-  based on a scenario around dental operations and the risk of Infective endocarditis
-  "Infective endocarditis is an infection of the inner surface of the heart, usually the valves." https://en.wikipedia.org/wiki/Infective_endocarditis
-  several risk factors, cause: bacterial infection
-  connection to dental operation: oral flora and enter the bloodstream usually by dental surgical procedures (tooth extractions)
-  for high risk patience preventive antibiotics are injected intravenously (possibly using a smart pump)
-  The usefulness of antibiotics following dental procedures for prevention is unclear
-  25% of the infected die (if no therapy is applied it leads to death in most cases)
-  https://en.wikipedia.org/wiki/Infective_endocarditis

-  synthetic dataset


### event types and data analysis
-  9 event types
  -  action
  -  action_by
  -  action_type
  -  dental
  -  dental_on
  -  patient
  -  patient_id
  -  pump
  -  pump_on

examples: (write attribute name, attribute type and example attribute value for each)

various numbers for all parameters except
  second parameter of action_type: ['noise', 'antibiotics']
  second parameter of patient_id: ['Alice', 'Bob', 'Charlie']

### TODO conditions, property formulation, results, short summary/ description of results, performance analysis

# discussion
