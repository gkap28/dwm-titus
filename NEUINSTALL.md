# Neuinstallation Fedora-dwm (mein Setup)

Jeden Schritt einzeln ausführen. Hinter jedem Schritt steht, was du sehen solltest. Stimmt es nicht, hör auf und frag nach.

## 1. Fedora-dwm installieren
Von der ISO wie gewohnt. Danach anmelden und ein Terminal öffnen.

## 2. GitHub-Zugang prüfen
Befehl:
    ssh -T git@github.com
Erwartet: "Hi gkap28! You've successfully authenticated"
Bei "Permission denied": zuerst `chmod 600 ~/.ssh/id_ed25519`, dann den Befehl wiederholen.
Fehlt die Datei ~/.ssh/id_ed25519 ganz, musst du einen neuen Schlüssel anlegen und bei GitHub hinterlegen (https://github.com/settings/keys).

## 3. Fork klonen und installieren
Befehle, nacheinander:
    git clone https://github.com/gkap28/dwm-titus.git ~/Projects/dwm-titus
    cd ~/Projects/dwm-titus
    git status
    sudo make install
Erwartet bei `git status`: "nothing to commit, working tree clean" und "On branch main".
Der Installer schreibt die Updater-Adresse (gkap28/dwm-titus) automatisch.

## 4. Upstream verbinden (für spätere Updates von ChrisTitusTech)
Befehl:
    git -C ~/Projects/dwm-titus remote add upstream https://github.com/ChrisTitusTech/dwm-titus.git
Erwartet: keine Ausgabe.

## 5. (entfällt)
Die Updater-Adresse wird durch `make install` gesetzt. Nichts von Hand ändern.

## 6. Prüfen, ob ein Update da ist
Befehl:
    /usr/local/bin/dwm-desktop-update check --force
Erwartet: "state": "available". Das ist normal, weil der Fork neuer ist als die Neuinstallation.

## 7. Desktop-Update installieren
Im Control Center: System → Check Update → Desktop-Update.
Während es läuft: nicht neu starten.
Danach prüfen:
    /usr/local/bin/dwm-desktop-update status
Erwartet: "state": "current" und "changes": []

## 8. Neustart und Test
Brave vorher mit Strg+Q schließen, dann neu starten.
Erwartet: Layout-Knopf in der Leiste, Uhr zeigt Sekunden nach Schalter-Einstellung, und der Befehl aus Schritt 7 meldet wieder "current".

## Wichtige Regeln
- Dateien in ~/.config/quickshell nie von Hand ändern. Sie werden vom Updater verwaltet.
- Eigene Änderungen nur in ~/Projects/dwm-titus machen, dann committen und mit `git push origin main` hochladen.
- Danach im Control Center das Desktop-Update installieren (Schritt 7).
- Upstream-Updates von ChrisTitusTech holen: `git -C ~/Projects/dwm-titus fetch upstream`, dann `git -C ~/Projects/dwm-titus merge upstream/main`, dann `git -C ~/Projects/dwm-titus push origin main`.
- Bei Konflikten in scripts/dwm-desktop-update (Zeile 26): Die Fork-Adresse behalten.
