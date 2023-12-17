import psutil

print("hello world")

memrestant = psutil.virtual_memory().percent #memoire restante disponible en %
print("memrestant%")

memutilisé = 100-psutil.virtual_memory().percent  #memoire utliser en %
print(memutilisé)

memoirerest = 16*memutilisé/100 #memoire utiliser

print(memoirerest)

print("bonjour vous utiliser",memoirerest,"% de memoire")

if memutilisé > 65 : print ("vous utliser trop de memoire")