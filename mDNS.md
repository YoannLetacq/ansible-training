### 🔹 Qu’est-ce que le mDNS ?

* **mDNS** = *Multicast DNS*.
* C’est une **version simplifiée de DNS** qui fonctionne **sans serveur DNS** :

  * Chaque machine sur le réseau local écoute et répond elle-même aux requêtes DNS envoyées à une adresse spéciale (*multicast*).
  * Résultat : pas besoin d’un DNS centralisé, les machines s’auto-découvrent.

Par exemple :

* Ton PC demande : « Qui est `web1.local` ? »
* La machine qui s’appelle `web1.local` répond directement : « C’est moi, mon IP est 192.168.1.10 ».

Tout ça se passe **uniquement sur le réseau local**, pas sur Internet.

---

### 🔹 Pourquoi ça force le `.local`

* **Le standard mDNS (RFC 6762)** impose que **tous les noms gérés par mDNS se terminent par `.local`**.
* C’est ce suffixe qui dit au système :

  > « Ne cherche pas ce nom sur Internet ni dans un DNS normal, mais via mDNS en local. »

Donc :

* `web1.local` → mDNS → broadcast local → IP trouvée
* `web1` → DNS classique ou `/etc/hosts` → IP trouvée (si configuré)

---

### 🔹 En résumé

| Nom          | Résolution par défaut     | Usage typique                      |
| ------------ | ------------------------- | ---------------------------------- |
| `web1.local` | mDNS (Multicast DNS)      | Réseau local sans DNS              |
| `web1`       | DNS normal / `/etc/hosts` | Réseau avec DNS ou config manuelle |

---

Si tu utilises Ansible **avec `ansible_connection=local`**, le nom n’est jamais résolu → `.local` ou pas, ça ne change rien.
Mais dès que tu fais du SSH normal, `web1.local` ne marchera **que si mDNS est actif** sur ton réseau.

