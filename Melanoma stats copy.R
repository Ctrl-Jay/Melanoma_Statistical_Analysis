#load package
library(tidyverse)

#load data
melanoma_data <- read_csv("/Users/Jidechukwu/Downloads/melanoma copy.csv")

#summary statistics without first column
summary(melanoma_data)[, -1]

#convert categorical variables to factors (status, sex, ulcer)
melanoma_data$status = factor(melanoma_data$status)
melanoma_data$sex = factor(melanoma_data$sex)
melanoma_data$ulcer = factor(melanoma_data$ulcer)

#summary statistics after correction
summary(melanoma_data)[, -1]

#graphical summaries
#set up a 2x2 grid for multiple plots
par(mfrow = c(2,2))

#plot histogram for numerical variable; time, age, year and thickness
hist(melanoma_data$time, main = "Time", xlab = "Time")
hist(melanoma_data$age, main = "Age", xlab = "Age")
hist(melanoma_data$year, main = "Year", xlab = "Year")
hist(melanoma_data$thickness, main = "Thickness", xlab = "Thickness")

#plot boxplot for numerical variable; time, age, year and thickness
boxplot(melanoma_data$time, main = "Time")
boxplot(melanoma_data$age, main = "Age")
boxplot(melanoma_data$year, main = "Year")
boxplot(melanoma_data$thickness, main = "Thickness")

#plot scatterplots for relationships; Age vs Thickness
plot(melanoma_data$age, melanoma_data$thickness,
     main = "Age vs Thickness",
     xlab = "Age",
     ylab = "Thickness")

#plot scatterplots for relationships; Thickness vs Time
plot(melanoma_data$thickness, melanoma_data$time,
     main = "Thickness vs Time",
     xlab = "Thickness",
     ylab = "Time")

#plot scatterplots for relationships; Age vs Time
plot(melanoma_data$age, melanoma_data$time,
     main = "Age vs Time",
     xlab = "Age",
     ylab = "Time")

#plot barchart for categorical variables; status
barplot(table(melanoma_data$status),
        main = "Status Distribution",
        xlab = "Status",
        ylab = "Frequency",
        col = "skyblue",
        border = "black",
        ylim = c(0, 150),
        names.arg = c("Died melanoma", "Alive", "Died unrelated"),
        cex.names = 0.8)

#plot barchart for categorical variables; sex
barplot(table(melanoma_data$sex),
        main = "Sex Distribution",
        xlab = "Sex",
        ylab = "Frequency",
        col = c("pink", "lightblue"),
        ylim = c(0, 200),
        names.arg = c("Female", "Male"),
        cex.names = 0.8)

#plot barchart for categorical variables; ulcer
barplot(table(melanoma_data$ulcer),
        main = "Ulcer Distribution",
        xlab = "Ulcer",
        ylab = "Frequency",
        col = c("lightgreen", "lightcoral"),
        ylim = c(0, 150),
        names.arg = c("Absent", "Present"),
        cex.names = 0.8)

#Regression Analysis; time ~ thickness
model_time_thickness <- lm(time ~ thickness, data = melanoma_data)

#Regression Analysis; time ~ age
model_time_age <- lm(time ~ age, data = melanoma_data)

#Regression Analysis; thickness ~ age
model_thickness_age <- lm(thickness ~ age, data = melanoma_data)

#Correlation computations
cor_time_thickness <- cor(melanoma_data$time, melanoma_data$thickness)
cor_time_age <- cor(melanoma_data$time, melanoma_data$age)
cor_thickness_age <- cor(melanoma_data$thickness, melanoma_data$age)

#Correlation computations between time, thickness and age
correlation_matrix <- cor(melanoma_data[c("time", "thickness", "age")])

#Results
model_time_thickness
model_time_age
model_thickness_age
cor_time_thickness
cor_time_age
cor_thickness_age
print(correlation_matrix)

#Extract and analyze coefficients from regression
coeff_time_thickness <- coef(model_time_thickness)
coeff_time_age <- coef(model_time_age)
coeff_thickness_age <- coef(model_thickness_age)

#Display regression summary
summary(model_time_thickness)
summary(model_time_age)
summary(model_thickness_age)

#T-test for significance
t_test_thickness_gender <- t.test(thickness ~ sex, data = melanoma_data)
t_test_age_gender <- t.test(age ~ sex, data = melanoma_data)
t_test_time_gender <- t.test(time ~ sex, data = melanoma_data)

#Print results
print(t_test_thickness_gender)
print(t_test_age_gender)
print(t_test_time_gender)

#QQ-Plots
plt_thickness <- ggplot(data = melanoma_data, aes(sample = thickness))
plt_thickness + stat_qq() + stat_qq_line() + facet_grid(. ~ sex)

plt_age <- ggplot(data = melanoma_data, aes(sample = age))
plt_age + stat_qq() + stat_qq_line() + facet_grid(. ~ sex)

plt_time <- ggplot(data = melanoma_data, aes(sample = time))
plt_time + stat_qq() + stat_qq_line() + facet_grid(. ~ sex)

