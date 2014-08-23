# Freifunk Münster Chef-Setup

Mit Hilfe dieses Repos können automatisiert Nodes aufgesetzt werden, die Teil des Freifunk-Netzes werden sollen.

## Voraussetzungen
* Softwareanforderungen:
  * Ruby >= 2.0
  * Bundler (`gem install bundler`)
* (Virtuellen) Server oder sonstigen Node mit SSH-Zugang

## Howto

Folgende Schritte müssen auf dem lokalen Rechner ausgeführt werden:

* Ruby-Abhängigkeiten per `bundle install` installieren
* Root-Zugang per SSH auf dem Zielnode einrichten. In diesem Beispiel nutzen wir einen Server unter der externen IP 10.52.52.52
* Die Datei `nodes/10.52.52.52.json` aus der Beispieldatei `nodes/10.52.52.52.json.example` erstellen. In dieser Datei können interne IP-Adresse und fastd-Key konfiguriert werden
* Den Ziel-Node fertig provisionieren: `bundle exec knife solo bootstrap root@10.52.52.52`

## Konfigurierbare Attribute

* `node[:fastd][:br0][:address]`: Interne IPv4-Adresse, z.B. `10.43.0.12`
* `node[:fastd][:br0][:netmask]`: Netzmaske des internen IPv4-Netzes, z.B. `255.255.0.0`
* `node[:fastd][:br0][:address]`: Interne IPv6-Adresse, z.B. `fd68:e2ea:a53::12`
* `node[:fastd][:br0][:address]`: Netzmaske des internen IPv6-Netzes, z.B. `48`
* `node[:fastd][:secret]`: Private-Key für fastd. Falls leer, wird ein neuer Key generiert.
* `node[:fastd][:bat0][:mac]`: Mac-Adresse des Mesh-VPN-Interfaces
