# File structure

```
root/
├─ .github/
│  ├─ workflows/
│  │  ├─ project/
│  │  │  ├─ cicd
│  │  │  ├─ integration_test
│
├─ project/
│  ├─ readme.md
│  ├─ src/
│
├─ project/
│  ├─ readme.md
│  ├─ src/
│
├─ readme.md
```

# Branch Rules / Branch structure
Branches are divided in minor major, with main and dev being the major branches.  
Each feature and/or user story will get their own branch, which will be considered minor branches.

CI/CD will happen on the primary minor branch and the major branches.
Versioning must be added to the minor branches BEFORE they are pushed to the major branches. 
This way the major branches will auto update what version it is running and can be shown in the versioning tab of github.  

# Team Schedule

| WeekDay   | Jacob         | Christian     | Mikkel        |
| --------- | ------------- | ------------- | ------------- |
| Monday    | 12:45 - 16:05 |               | 12:45 - 16:05 |
| Tuesday   | 08:20 - 11:50 | 08:20 - 16:05 | 08:20 - 11:50 |
| Wednesday | Bachelor      | Bachelor      | Bachelor      |
| Thursday  | 12:45 - 16:05 | 12:45 - 16:05 |               |
| Friday    |               |               | 08:20 - 11:50 |

# Commit and Review
These following things must be considered before approving a code review:
- Has there been written tests for the code.
- Do this code require tests.
- Does the code do as required by the feature / user story.
- Is the code commented.
- Has there been written documentation for the code.

# Documenting
Documenting is REQUIRED for each user story / feature uploaded to github.
Documenting all scenarios and etc. is not required. Document only the most interesting ones that there are in that case.
UML is not interesting. A flow chart or Sequence or System Sequence Diagram.

# Testing
Each feature must have an integration test coupled to it.
Automatic testing is required.

Testing is required where deemed necesarry by writer and reviewer.
Reviewer has the last say wether or not theres a need for a test.
