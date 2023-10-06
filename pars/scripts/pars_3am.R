# Get par values 

mods3am <- mods
d.pars <- data.table()

for(i in 1:length(mods3am)) {
    pp <- mods3am[[i]]$coef
    pp <- data.table(pars = names(mods3am)[[i]], t(pp))
    d.pars <- rbind(d.pars, pp, fill = TRUE)
}

parsl <- melt(d.pars, id.vars = 'pars', variable.name = 'parameter')

parsl

ps3am <- parsl[, .(val = mean(value, na.rm = TRUE)), by = parameter]

fixeddf <- ps3am[grepl('int\\.r2|int\\.r5|incorp|app.rate|man|wind|temp', parameter), ]
fixeddf
ps3am[!grepl('int\\.r2|int\\.r5|incorp|app.rate|man|wind|temp', parameter), ]
parsl[!grepl('int\\.r2|int\\.r5|incorp|app.rate|man|wind|temp', parameter), ]

fixed <- fixeddf[, val]
names(fixed) <- fixeddf[, parameter]

fixed3am <- fixed

