// Exemple de structure CSV avec mapping dynamique

/* Structure attendue:

Ligne 1 (Headers humains): Nom,Prénom,Fonction,Profession,Email,Numéro de tél
Ligne 2 (Keys mapping):    lastname,firstname,role,job,email,phone  
Ligne 3+ (Données):        de Mijolla-Mellor,Sophie,Présidente,"Psychanalyste, Professeur",email,phone

*/

const exampleCsv = `Nom,Prénom,Fonction,Profession,Email,Numéro de tél
lastname,firstname,role,job,email,phone
de Mijolla-Mellor,Sophie,Présidente,"Psychanalyste, Professeur émérite Université Paris 7 (Diderot), Directrice de la revue Topique",s.mijollamellor@gmail.com,06.11.53.66.18
Evita,Christelle,Secrétaire générale et trésorière,"Autrice, membre de l'A2IP",christelle.evita@gmail.com,06.70.63.45.80`;

console.log("Structure CSV avec mapping dynamique:");
console.log(exampleCsv);

console.log("\n--- AVANTAGES du mapping dynamique ---");
console.log("✅ Ordre des colonnes peut changer sans casser l'app");
console.log("✅ Mapping explicite via ligne 2");  
console.log("✅ Headers humains (ligne 1) + Keys techniques (ligne 2)");
console.log("✅ Robust aux modifications de structure Google Sheets");

console.log("\n--- EXEMPLES de flexibilité ---");
console.log("Si Google Sheets change l'ordre: Email,Nom,Prénom,Fonction...");
console.log("→ Il suffit de changer ligne 2: email,lastname,firstname,role...");
console.log("→ L'application continue de fonctionner sans modification code!");