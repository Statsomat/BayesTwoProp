# Bayes-Statistik, WS2024/2025
## Contributing to open-source is fun! 


1.	Statsomat https://statsomat.com 
    -	Minimal but sufficient GUI user-interaction 
    -	Automatic reporting 
    -	Human-readable interpretation in natural language
    -	Downloadable learner-code to reproduce the results 
    -	Help for learners and researchers all over the world
(Live-Show)

2.	Goal of this course: 
	- Is to develop an app for a statistical application treated by Bayes-theory and satisfying the Statsomat philosophy. 
	- We will start with a "starting code" which we will extend and develop. The "starting code" is the code developed by students during WS21/22. 
	- The statistical application performs the automated analysis of the relationship between two proportions (difference, ratio, efficacy) by using models:  
		-  Analytically (priors given by Beta distributions)
		-  MCMC simulation (priors given by Beta distributions)
(Live-Show)
 
3.	Technical:
	- GitHub Web (repository and project) https://github.com/reyar/BayesTwoProp
	- GitHub Desktop https://desktop.github.com/download/
	- R Studio Desktop & R 
	- R Posit Cloud (we need to check if the free resources are satisfactory)
	- OLAT: Only for announcements (Mitteilungen)
	- Zoom: In special cases 

    - ToDo: Sign up to GitHub, download and install GitHub Desktop , clone the reyar/BayesTwoProp repository, install R, RStudio and all the required packages demanded by the R scripts.
    - Alternatively to local RStudio: Work in the R Posit Cloud, connect reyar/BayesTwoProp repository and you will get a token (a password). If the resources are not satisfactory, you can work in my account (to check) 
(send invitations) 

4.  Issues and Project:
	- Check the Roadmap of the Project 
    - Start with introductory issues 
    - Rules for next issues
        - Each student should work on at least one issue 
        - Pick up a next open issue and create a new branch FROM inside the issue to make your contribution 
        - Commit significant changes to the branch and push them to the cloud
        - Open a pull request to add significant commits to the master
(Live-Show)
 
5.	Evaluation of your contributions (comments, commits, additions, deletions, reviews/tests) at 31.01.2024, 10:00. There are no limits set. Please check the insight of the project to see the work of other students. 
(Live-Show)

# Literature and Useful Links 
(additional to references of Prof. Neuhäuser) 

1. GitHub Fundamentals (https://github.com/reyar/BayesTwoProp/blob/master/documents/Git_Fundamentals.md)
2. Kruschke, John K., Bayesian Analysis Reporting Guidelines, Nature Human Behaviour, 2021,  (https://www.nature.com/articles/s41562-021-01177-7#rightslink) (check also the file in the documents folder)
3. Kruschke, John K., BARG-Supplement.html: https://osf.io/w7cph/ (check also the file in the documents folder)
4. Kruschke, John K., Doing Bayesian Data Analysis, Elsevier 2015, ISBN: 978-0-12-405888-0, especially chapters 6, 7 and 8.4 (https://nyu-cdsc.github.io/learningr/assets/kruschke_bayesian_in_R.pdf)
6. Rmarkdown (https://bookdown.org/yihui/rmarkdown/), (https://bookdown.org/yihui/rmarkdown-cookbook/)
7. Shiny Gallery (https://shiny.rstudio.com/gallery/#demos)
8. Datasets: Adverse Events of Vaccine and Sars-Cov-2 (https://www.nejm.org/doi/full/10.1056/NEJMoa2110475, https://www.nejm.org/doi/suppl/10.1056/NEJMoa2110475/suppl_file/nejmoa2110475_appendix.pdf)
9. Datasets: Pfizer Vaccine (https://arxiv.org/abs/2102.11022v1)
10. Most docs also under /documents


# Further Comments
-	Please use the `data.table` package for EDA (extract, transform, load) data. Use the package `dplyr` only if really needed.
-	Debugging: Discuss the errors in our group. Use AI programming copilots.
-	Programming best practices:
    - Use human-readable object names (e.g. do not name objects with `x` or `y`) 
    - Write short lines (break the lines if they are too long)
    - Comment properly the lines for newcomers 
    - Use blank lines between blocks of code representing distinct ideas
    - Do not use libraries which do not have a large community  


# ChatGPT & other AIs: 
- When programming: Allowed and recommended. You need to know WHAT you want to program. It doesn't matter where you got the codes from. The main thing is that they are ALLOWABLE lines of code and, ideally, ELEGANT lines of code. 
- Except programming: Allowed with the following instructions: 
	- AIs can make mistakes, provide incorrect information or give distorted answers. You must ADDITIONALLY carry out your own research (especially for risky statements). Every statement from your work that was generated with the help of AI should ideally be checked and confirmed by existing sources in the form of, for example, ISBN or DOI. 
	- Pay attention to the privacy of your own data or data of others. Do not provide personal or sensitive data to AI to third parties without permission. 
	- Do not offer the AI ​​morally objectionable statements as training data.


