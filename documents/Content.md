# Bayes-Statistik, WS2021/2022
by Dr. Denise Welsch

# Content 
-	Welcome
-	Statsomat https://statsomat.com 
    -	Minimal but sufficient GUI user-interaction 
    -	Automatic reporting (automated tables and graphics) 
    -	Human-readable interpretation 
    -	Downloadable learner-code to reproduce the results 
    -	Help for learners all over the world 

-	Goal: The goal of this course is to develop an app for a statistical application treated by Bayes-theory and satisfying the Statsomat philosophy. We will start with a "starting code" which we will extend and develop. The statistical application is the relationship of two proportions (difference, ratio, efficacy) by using two models: 
    -  Analytically (priors given by Beta distributions)
    -  MCMC simulation (priors given by Beta distributions)

-	GitHub und GitHuB Desktop, our repository and the subdirectories 

-	Evaluation of your contributions (commits, additions, deletions, comments, pull requests, reviews). Each issue needs a developer lead, (several) tester and reviewers. 

-	Installation: Download and Install GitHub Desktop, clone GitHub repository, install R, RStudio, tinytex (https://bookdown.org/yihui/rmarkdown-cookbook/install-latex.html) and all the required packages demanded by the R scripts. Alternatively: Work on RCloud. 

- Start with Issue 1,2,3. 

- Pick up further issues, work on them and resolve them. 

Contribution to open-source is fun! 

# Literature and Useful Links 
(additional to Literature from the course of Prof. Neuhäuser) 

1. GitHub Fundamentals (https://github.com/reyar/BayesTwoProp/blob/master/documents/Git_Fundamentals.md)
2. Kruschke, John K., Bayesian Analysis Reporting Guidelines, Nature Human Behaviour, 2021,  (https://www.nature.com/articles/s41562-021-01177-7#rightslink)
3. Kruschke, John K., BARG-Supplement.html: https://osf.io/w7cph/ (check the html file)
4. Kruschke, John K., Doing Bayesian Data Analysis, Elsevier 2015, ISBN: 978-0-12-405888-0, especially chapters 6,7 and 8.4
5. Rmarkdown (https://bookdown.org/yihui/rmarkdown/), (https://bookdown.org/yihui/rmarkdown-cookbook/)
6. Shiny Gallery (https://shiny.rstudio.com/gallery/#demos)
7. Datasets: Adverse Events of Vaccine and Sars-Cov-2 (https://www.nejm.org/doi/full/10.1056/NEJMoa2110475, https://www.nejm.org/doi/suppl/10.1056/NEJMoa2110475/suppl_file/nejmoa2110475_appendix.pdf)
8. Datasets: Pfizer Vaccine (https://arxiv.org/abs/2102.11022v1)

Google Drive Denise Welsch: (https://drive.google.com/drive/folders/1baXEFnHuUCJLmgvrdR93Q0tlIr5B3uze?usp=sharing) 


# Further Comments
-	Please use the `data.table` package for EDA (extract, transform, load) data. Use the package `dplyr` only if really needed.
-	Debugging: Discuss the errors in our group. Google the errors. Check solutions on StackOverflow or on the official GitHub pages of the R packages. 
-	Programming best practices:
    - Use human-readable object names (e.g. do not name objects with `x` or `y`) 
    - Write short lines (break the lines if they are too long)
    - Comment properly the lines for newcomers 
    - Use blank lines between blocks of code representing distinct ideas
    - Do not use libraries which do not have a large community  
-   Should you have new ideas, you are welcomed to open an issue (also for very small changes) 
-	Prerequisites: Course of Prof. Neuhäuser, R programming 
-	Filter to search issues by commenter in GitHub is:issue is:open commenter:reyar 


