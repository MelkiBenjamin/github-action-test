import psutil
import math

print("hello world")

memrestant = psutil.virtual_memory().percent #memoire restante disponible en %
print(memrestant)
print("Bonjour vous avez ",memrestant,"% de memoire restante disponible.")

memutilisé = 100-psutil.virtual_memory().percent  #memoire utliser en %
print(memutilisé)
print("Bonjour vous utiliser ",memutilisé,"% de memoire.")

memoirerest = 16*memutilisé/100 #memoire utiliser
print(memoirerest) #sans arrondie
memar = format(memoirerest, '.2f')  #memoire utlisé arrondie
print(memar, 'en arrondit')
print("Bonjour vous utiliser ",memar,"GO de memoire.")

if memutilisé > 65 : print ("Attention, vous utliser trop de memoire.")