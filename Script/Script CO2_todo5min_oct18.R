print ("This file was created within RStudio")
print("And now it lives on GitHub")

#Datos para determinar el Minimal Detectable Flux - f. detect - app Dr. Hüppi
#para cinco minutos riego 1 y 2 
# tiempo: 0; 0.006; 0.012; 0.018; 0.024; 0.030; 0.036; 0.042; 0.048; 0.054; 0.061; 0.067; 0.073; 0.079; 0.085; 0.091
# cámara: área cámara (m2): 0.169646
# volumen cámara (m3): 0.05340072
#  desv. estándar CO2: 122.06 (ppb)
# opción: No lineal
# resultado app: 
# [1] "Estimated minimal detectable flux:"
# 97.5% 
#283.6154  
# [1] "[mg CO2/m^2/h ]"
# [1] "Number of HMR fluxes detected:"
# [1] 25

# Análisis gasfluxes: 
library("gasfluxes")
fluxMeas_CO2_todo5 <- read_excel("Data/BaseR_CO2/BaseR_CO2COM_5minTODO.xlsx")

gasfluxes(fluxMeas_CO2_todo5, .id = "serie", .V = "V", .A = "A", .times = "time",.C = "C", methods = c("linear", "robust linear", "HMR", "NDFE"),k_HMR = log(1.5), k_NDFE = log(0.01),verbose = FALSE, plot = FALSE)
f.detect <- 283.6154  

t.meas3 <- max(fluxMeas_CO2_todo5$time)
# resultado t.meas: 0.090833333262708

resCO2_t5 <- gasfluxes(fluxMeas_CO2_todo5,.id = "serie", .V = "V", .A = "A",.times = "time", .C = "C",methods = c("linear", "robust linear", "HMR"), verbose = FALSE, plot = FALSE)
selectfluxes(resCO2_t5, "kappa.max", f.detect = f.detect, t.meas = t.meas)
write.table(resCO2_t5, file="Res_CO2_5min_todo_18oct.csv", row.names = FALSE, sep = " , ")
