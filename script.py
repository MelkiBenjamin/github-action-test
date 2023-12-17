import psutil

print("hello world")

memrestant = psutil.virtual_memory().percent #memoire restante disponible en %
print(memrestant)
print("Bonjour vous avez ",memrestant," % de memoire restante disponible.")

memutilisé = 100-psutil.virtual_memory().percent  #memoire utliser en %
print(memutilisé)
print("Bonjour vous utiliser ",memutilisé," % de memoire.")

memoirerest = 16*memutilisé/100 #memoire utiliser
print(memoirerest)
print("Bonjour vous utiliser ",memoirerest," de memoire.")

if memutilisé > 65 : print ("vous utliser trop de memoire.")