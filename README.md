# Shellkit — CPSC 298Nix, Fall 2026

Please read this README carefully before beginning.

## Assignment summary

This is a **GitHub collaboration** assignment. Your goal is not to rewrite the whole project. Your goal is to practice the workflow used in real open-source and team projects.

**What you need to do:**

1. **Fork** this repository and **clone** your fork (to local).
    * see [here](https://docs.github.com/en/pull-requests/how-tos/work-with-forks/fork-a-repo) for documentation on forking a repository on GitHub.
2. **Pick one open issue** (start with `good first issue` if you want an easier one).
3. **Comment on the issue** to claim it. Comment only your **first name and last initial** to identify yourself. 
    * Once an issue is claimed in a comment, you cannot take it for yourself, even if the PR hasn't been submitted. You must respect your co-collaborators.
4. **Create a branch** for that issue only.
5. **Make the smallest change** that matches the issue’s acceptance criteria.
6. **Test** your change (`bash tests/test_scripts.sh` or `./tests/test_scripts.sh`).
7. **Commit and push to your forked repo**. You are not a contributor on the repo, so your PR must come from your fork (aka the copy of the repository that YOU own).
8. **Open a pull request** that links the issue. Make sure the PR has a proper description as shown in class.
8. Make sure the **GitHub Actions checks** on your PR are green.
10. **COMPLETELY OPTIONAL**: If you think of another issue (e.g. another script to implement), you are more than welcome to submit an issue as well. Please make sure the issue is well formatted (as specified in class).

That is the whole assignment loop. Most issues take about **15–40 minutes** once you have Git working. Spend your time reading the issue and using Git, not building a large program from scratch.

These scripts are meant to run with **Bash on Ubuntu (WSL)** or **Bash on macOS**. Use basic Bash and common commands so your change works in either place.

### Scope

Two important things to note:

**1. You can consult the internet**

This assignment is aimed for practicing the git/GitHub workflow common in collaborative projects. While there are lots of issues regarding shell scripts, shell scripting is not the focus. 

You are more than welcome to consult the internet, documentation, etc. to solve a given issue (because that's what you would do if this was a real project!). 

If you find code that solves your exact issue (e.g. you chose an issue that asks for a new script and you found that exact working script online), please make sure to cite it via commenting the source in the shell script. 

Citing your sources is still important! Even/especially with code!!

**2. DO NOT automate this with AI**

The whole point of this assignment is to get **YOU THE HUMAN** familiar with this process. If you have an agent do it the entire exercise loses meaning and this assignment just becomes supporting evidence for the Dead Internet Theory.



---

## What this repository is

Shellkit is a small set of Bash scripts and sample data files. Some scripts have intentional bugs. Some issues ask you to add a short new script or edit a data file. Every issue tells you **which file to change** and, for bugs, **how to reproduce** the problem.

You do **not** need to understand every script in the repo. Open only the file named in your issue.

## Repository layout

```
.
├── README.md
├── scripts/          # Bash scripts you may change or add
├── data/             # Sample files the scripts read
├── tests/
│   └── test_scripts.sh
└── .github/
    └── workflows/    # Automated checks on pull requests
```

| Path | Purpose |
| ---- | ------- |
| `scripts/` | Short utility scripts |
| `data/` | Sample text, a sample log, and related files |
| `tests/test_scripts.sh` | Smoke tests — run these before you open a PR |
| `.github/workflows/` | GitHub Actions (script tests + ShellCheck) |

## Setup

1. Fork this repository on GitHub.
2. Clone **your fork** to your machine.
3. Work from the repository root (the folder that contains `scripts/` and `data/`):

```bash
cd shellkit-cpsc298nix-f26
```

(If your clone folder has a different name, `cd` into that folder instead.)

## Running a script

Always run scripts from the repository root:

```bash
./scripts/greeting.sh
./scripts/filecount.sh
./scripts/wordcount.sh
```

If the issue gives reproduce commands, run those first so you can see the bug yourself.

## Running the tests

From the repository root:

```bash
bash tests/test_scripts.sh
```

These tests should pass on a fresh clone. Run them again after your change. A good fix for one issue should not break the rest of the project.

When your pull request changes scripts, data, or tests, GitHub Actions also runs:

- **Script tests** — the same `tests/test_scripts.sh` checks
- **ShellCheck** — catches common Bash mistakes

If a check is red, read the log, fix the problem, and push again.

## Step-by-step contribution workflow

1. **Find an open issue** on this GitHub repository.
2. **Claim it** by commenting (follow your instructor’s claiming rule).
3. **Create a branch** named after the issue, for example:

   ```bash
   git checkout -b fix-greeting-empty-username
   ```

4. **Edit only the file(s) the issue asks for.** Do not mix unrelated fixes into the same PR.
5. **Try the script** (or inspect the data file), then run:

   ```bash
   bash tests/test_scripts.sh
   ```

6. **Commit and push** your branch to your fork.
7. **Open a pull request** into the class repository. In the PR description:
   - link the issue
   - say in one or two sentences what you changed

## What a good pull request looks like

- Solves **one** issue
- Title and description match that issue
- Automated checks are green
- Diff is small and easy to review

## Tips for this class

- Read the issue’s **File to change**, **How to reproduce**, and **Acceptance criteria** before editing.
- Use `cat`, `less`, or your editor to read that one script once. You do not need to study every file in `scripts/`.
- If tests fail, read the `FAIL` line and fix that first.
- If the acceptance criteria are unclear, ask on the issue or in class. Do not rewrite the whole script “to be nicer.”
- Keep your change small. Small PRs are easier to review and more likely to be merged.
- Prefer portable commands. Avoid GNU-only `find` options such as `-newermt`, and do not hard-code Linux-only or Mac-only paths.
