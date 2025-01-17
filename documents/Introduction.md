# Bayes-Statistik, WS2024/2025
## Contributing to open-source is fun! 


## Statsomat https://statsomat.com 
-	Automated Statistical Data Analysis and Reporting
-	Human-readable interpretation in natural language
-	Downloadable learner-code to reproduce the results 
-	Help for learners and researchers all over the world
- 	Open-source 


## Goal: 
- Is to develop an app for a statistical application treated by Bayes-theory and satisfying the Statsomat philosophy.
- The name of the app is "Statsomat/BayesTwoProp" 
- The statistical application shall perform the automated analysis of the relationship between two proportions (difference, ratio, efficacy) by using models:  
	-  Analytically (priors given by Beta distributions)
	-  MCMC simulation (priors given by Beta distributions)
- We will start with a "starting code" which we will extend and further develop. The "starting code" is the code developed by students during WS21/22. 

(Live-Show)

## Learning Objectives
- Learn to apply Bayes theory on a certain data problem 
- Learn to code with R (diverse packages)
- Learn to work with Git and GitHub
- Learn to collaborate in software engineering projects 

## Technical Components:
- Git (a version control system used by developers to track changes in their code over time) https://git-scm.com/
- GitHub (web-based platform that uses Git for version control) https://github.com/reyar/BayesTwoProp
- GitHub clients: "GitHub Desktop" https://desktop.github.com/download/ or "TortoiseGit" https://tortoisegit.org/ or "RPosit" https://posit.cloud/
- R
- R GUIs: RStudio Desktop, RPosit Cloud
- OLAT: Only for announcements (Mitteilungen)
- Zoom: In special cases 

- Work at RAC (1): R + RStudio Desktop + Tortoise + GitHub
- Work at RAC (2): R + RStudio Desktop + GitHub Desktop (soon) + GitHub
- Work at RAC (3): R + RPosit + GitHub
- Work at Home (4): R + RStudio Desktop + GitHub Desktop + GitHub
- Work at Home (5): R + RPosit + GitHub
	
	
##  GitHub Issues and Project:
- Check the Roadmap of the Project 
- Work the Project line 
- Rules for next issues
- Each student group should work on at least one issue, I will allocate the issues to groups 
- Create a new branch FROM INSIDE the issue in GitHub and do here your work 
- Commit significant changes to the branch and push them to the cloud
- Open a pull request to add significant commits to the master
- Do not work on master! 

(Live-Show)
 
##	Evaluation

GitHub Traces (Commits, Comments etc, for the group), Written Report (Delivery: 28.02.2025, 10:00. Describe: The (prospected) functions of the app, our work during the semester, my own contribution, approx. 1500 words). Details at the beginning of January. 

(Live-Show)

## Workload at home
Approx. 3h/week 

## Open-Source Software at GitHub
- The repository reyar/BayesTwoprop is currently private
- When finalized, the repository will be set on public and will be open-source
- Open-source software is a great source of learning and motivation for humans and non-humans... 
- Your contribution will be visible everywhere besides the issues (these will be deleted in advance)
- Your contribution increases your reputation in your future career
- If we will not finalize the app during this semester, then your contribution within the issues will be visible for future students working on the app
- You agree with the terms of GitHub 


## Literature and Useful Links 
(additional to references of Prof. Neuhäuser) 

1. GitHub Fundamentals (https://github.com/reyar/BayesTwoProp/blob/master/documents/Git_Fundamentals.md)
2. Bayes: Kruschke, John K., Bayesian Analysis Reporting Guidelines, Nature Human Behaviour, 2021,  (https://www.nature.com/articles/s41562-021-01177-7#rightslink) (check also the file in the documents folder)
3. Bayes: Kruschke, John K., BARG-Supplement.html: https://osf.io/w7cph/ (check also the file in the documents folder)
4. Bayes: Kruschke, John K., Doing Bayesian Data Analysis, Elsevier 2015, ISBN: 978-0-12-405888-0, especially chapters 6, 7 and 8.4 (https://nyu-cdsc.github.io/learningr/assets/kruschke_bayesian_in_R.pdf)
5. Bayes: https://www.bayesrulesbook.com/chapter-3
6. Rmarkdown: (https://bookdown.org/yihui/rmarkdown/), (https://bookdown.org/yihui/rmarkdown-cookbook/)
7. Shiny: Shiny Gallery (https://shiny.rstudio.com/gallery/#demos)
8. Datasets: Adverse Events of Vaccine and Sars-Cov-2 (https://www.nejm.org/doi/full/10.1056/NEJMoa2110475, https://www.nejm.org/doi/suppl/10.1056/NEJMoa2110475/suppl_file/nejmoa2110475_appendix.pdf)
9. Datasets: Pfizer Vaccine (https://arxiv.org/abs/2102.11022v1)
10. Most of the docs also under /documents


## Further Comments
- Please use the `data.table` package for EDA (extract, transform, load) data. Use the package `dplyr` only if really needed.
- Debugging: Discuss the errors in our group. Use AI programming copilots.
- Programming best practices:
- Use human-readable object names (e.g. do not name objects with `x` or `y`) 
- Write short lines (break the lines if they are too long)
- Comment properly the lines for newcomers 
- Use blank lines between blocks of code representing distinct ideas
- Do not use libraries which do not have a large community  


## ChatGPT & other AIs: 
- For programming: Allowed and recommended. You need to know WHAT you want to program. It doesn't matter where you got the codes from. The main thing is that they are ALLOWABLE lines of code and, ideally, ELEGANT lines of code. 
- Other: Allowed with the following instructions: 
- AIs can make mistakes, provide incorrect information or give distorted answers. Check mistakes. Every statement from your work that was generated with the help of AI should ideally be checked and confirmed by existing sources in the form of, for example, ISBN or DOI. 
- Pay attention to the privacy of your own data or data of others. Do not provide personal or sensitive data to AI to third parties without permission. 
- Do not offer the AI ​​morally objectionable statements as training data.


## Let's start 
- Send invitations from GitHub, Rposit workspace, token 
- Work at RAC (1): Sign up to GitHub, clone the reyar/BayesTwoProp repository from TortoiseGit (see document documents/Clone_repo_tortoisegit.md)
- Work at Home (4): Sign up to GitHub, download and install GitHub Desktop, clone the reyar/BayesTwoProp repository, install R, RStudio and all the required packages demanded by the R scripts
- Work RAC/Home (3) and (5): Create a token in GitHub, connect the reyar/BayesTwoProp repository in RPosit (see document documents/Create_GitHub_Token.md).   
