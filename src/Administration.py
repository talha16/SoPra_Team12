from bo.Gehen import Gehen
from bo.Kommen import Kommen
from bo.Ereignisbuchung import Ereignisbuchung
from bo.Urlaub import Urlaub
from bo.Person import Person
from bo.Zeitintervallbuchung import Zeitinverallbuchung
from bo.Projektarbeit import Projektarbeit
from bo.Aktivitaet import Aktivitaet
from bo.Pause import Pause
from bo.VerkaufteStundenInAktivitaet import VerkaufteStundenInAktivitaet
from bo.User import User

from db.ProjektMapper import ProjektMapper
from db.PersonMapper import PersonMapper
from db.AktivitaetMapper import AktivitaetMapper
from db.UrlaubMapper import UrlaubMapper
from db.PauseMapper import PauseMapper
from bo.Projekt import Projekt
from db.ProjektarbeitMapper import ProjektarbeitMapper
from bo.Mitarbeiterinprojekt import MitarbeiterInProjekt
from db.MitarbeiterInProjektMapper import MitarbeiterInProjektMapper
from db.VerkaufteStundenInAktivitaetMapper import VerkaufteStundenInAktivitaetMapper
from db.ZeitintervallbuchungMapper import ZeitintervallbuchungMapper
from db.KommenMapper import KommenMapper
from db.GehenMapper import GehenMapper
from db.EreignisbuchungMapper import EreignisbuchungMapper
from db.UserMapper import UserMapper
import datetime

"""
 * @author [Aykut Demir](https://github.com/AykutDemirr)
 * @author [Dennis Kühnberger](https://github.com/Dennis-248)
 * @author [Nicola Pany](https://github.com/NicolaPany)
 * @author [Talha Yildirim](https://github.com/talha16)
 * @author [Manuel Bräuninger](https://github.com/manu-br)
"""

class Administration(object):

    def __init__(self):
        pass

    def create_user(self, name, email, google_user_id):
        """Einen Benutzer anlegen"""
        user = User()
        user.set_name(name)
        user.set_email(email)
        user.set_user_id(google_user_id)
        user.set_id(1)

        with UserMapper() as mapper:
            return mapper.insert(user)

    def get_user_by_name(self, name):
        """Alle Benutzer mit Namen name auslesen."""
        with UserMapper() as mapper:
            return mapper.find_by_name(name)

    def get_user_by_id(self, number):
        """Den Benutzer mit der gegebenen ID auslesen."""
        with UserMapper() as mapper:
            return mapper.find_by_key(number)

    def get_user_by_email(self, email):
        """Alle Benutzer mit gegebener E-Mail-Adresse auslesen."""
        with UserMapper() as mapper:
            return mapper.find_by_email(email)

    def get_user_by_google_user_id(self, id):
        """Den Benutzer mit der gegebenen Google ID auslesen."""
        with UserMapper() as mapper:
            return mapper.find_by_google_user_id(id)

    def get_all_users(self):
        """Alle Benutzer auslesen."""
        with UserMapper() as mapper:
            return mapper.find_all()

    def save_user(self, user):
        """Den gegebenen Benutzer speichern."""
        with UserMapper() as mapper:
            mapper.update(user)

    def delete_user(self, user):
        """Den gegebenen Benutzer aus unserem System löschen."""
        with UserMapper() as mapper:
            mapper.delete(user)

    """Person"""
    def create_person(self, vorname, nachname, mail_adresse, benutzername):
        """Eine Person anlegen."""
        person = Person()
        person.set_id(1211)
        person.set_vorname(vorname)
        person.set_nachname(nachname)
        person.set_mail_adresse(mail_adresse)
        person.set_benutzername(benutzername)
        person.set_urlaubstage(30)
        person.set_ueberstunden(0)
        """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""
        person.set_letzte_aenderung()

        with PersonMapper() as mapper:
            return mapper.insert(person)

    def get_all_personen(self):
        """ Wir geben alle Personen aus """
        with PersonMapper() as mapper:
            return mapper.find_all()

    def get_person_by_id(self, person_id):
        """ Wir geben die Person mit der angegebenen ID zurück """
        with PersonMapper() as mapper:
            return mapper.find_by_id(person_id)

    def get_person_by_benutzername(self, benutzername):
        """ Wir geben die Person mit dem angegebenen Benutzernamen zurück """
        with PersonMapper() as mapper:
            return mapper.find_by_benutzername(benutzername)

    def delete_person_by_person_id(self, person_id):
        """ Wir löschen die Person anhand der angegebenen Personen ID """
        with PersonMapper() as mapper:
            #person = self.get_all_personen()
            return mapper.delete(person_id)

    def update_person(self, person):
        """ Wir aktualisieren die Person und weißen letzte_aenderung neu zu"""
        person.set_letzte_aenderung()

        with PersonMapper() as mapper:
            return mapper.update(person)

    """Projekt"""
    def create_projekt(self, projektleiter, projektname, auftraggeber):
            """Ein Projekt anlegen."""
            projekt = Projekt()
            projekt.set_id(1211)
            projekt.set_projektleiter(projektleiter)
            projekt.set_name(projektname)
            projekt.set_auftraggeber(auftraggeber)
            """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""
            projekt.set_letzte_aenderung()

            with ProjektMapper() as mapper:
                return mapper.insert(projekt)

    def get_all_projekte(self):
        """ Wir geben alle Projekte aus """
        with ProjektMapper() as mapper:
            return mapper.find_all()

    def delete_projekt_by_id(self, projekt_id):
        """ Wir löschen ein Projekt anhand der angegebenen ID """
        with ProjektMapper() as mapper:
            return mapper.delete(projekt_id)

    def update_projekt(self, projekt):
        """ Wir aktualisieren das Projekt und weißen letzte_aenderung neu zu"""
        projekt.set_letzte_aenderung()

        with ProjektMapper() as mapper:
            return mapper.update(projekt)

    """Aktivität"""
    def create_aktivitaet(self, projekt_id, bezeichnung, dauer, kapazitaet):
        """Eine Aktivität anlegen."""

        aktivitaet = Aktivitaet()
        aktivitaet.set_id(1211)
        aktivitaet.set_projektname(projekt_id)
        aktivitaet.set_name(bezeichnung)
        aktivitaet.set_dauer(dauer)
        aktivitaet.set_kapazitaet(kapazitaet)
        """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""
        aktivitaet.set_letzte_aenderung()

        with AktivitaetMapper() as mapper:
            return mapper.insert(aktivitaet)

    def get_all_aktivitaeten(self):
        """ Wir geben alle Aktivitäten aus """
        with AktivitaetMapper() as mapper:
            return mapper.find_all()

    def get_aktivitaet_by_id(self, aktivitaet_id):
        """ Wir geben die Aktivität mit der angegebenen ID zurück """
        with AktivitaetMapper() as mapper:
            return mapper.find_by_id(aktivitaet_id)

    def delete_aktivitaet_by_aktivitaet_id(self, aktivitaet_id):
        """ Wir löschen die Aktivität anhand der angegebenen Aktivität ID """
        with AktivitaetMapper() as mapper:
            return mapper.delete(aktivitaet_id)

    def update_aktivitaet(self, aktivitaet):
        """ Wir aktualisieren die Aktivität und weißen letzte_aenderung neu zu"""
        aktivitaet.set_letzte_aenderung()

        with AktivitaetMapper() as mapper:
            return mapper.update(aktivitaet)

    """Pause"""
    def create_pause(self, person_id, start_pause, ende_pause):
        """Pause anlegen"""

        pause = Pause()
        pause.set_id(1211)
        pause.set_person_id(person_id)
        pause.set_start_pause(start_pause)
        pause.set_ende_pause(ende_pause)
        pause.set_letzte_aenderung()

        with PauseMapper() as mapper:
            return mapper.insert(pause)


    def get_all_pause(self):
        """ Wir geben alle Pausen aus """
        with PauseMapper() as mapper:
            return mapper.find_all()

    def get_pause_by_id(self, pause_id):
        """ Wir geben die Pause mit der angegebenen ID zurück """
        with PauseMapper() as mapper:
            return mapper.find_by_id(pause_id)

    def delete_pause_by_pause_id(self, pause_id):
        """ Wir löschen die Pause anhand der angegebenen Pause ID """
        with PauseMapper() as mapper:
            return mapper.delete(pause_id)

    def update_pause(self, pause):
        """ Wir aktualisieren die Pause und weißen letzte_aenderung neu zu"""
        pause.set_letzte_aenderung()

        with PauseMapper() as mapper:
            return mapper.update(pause)

    """Projektarbeit"""
    def create_projektarbeit(self, projekt_id, person_id, aktivitaet_id, start, ende):
        """Projektarbeit anlegen"""

        projektarbeit = Projektarbeit()
        projektarbeit.set_id(1211)
        projektarbeit.set_projekt_id(projekt_id)
        projektarbeit.set_person_id(person_id)
        projektarbeit.set_aktivitaet_id(aktivitaet_id)
        projektarbeit.set_start(start)
        projektarbeit.set_ende(ende)
        projektarbeit.set_letzte_aenderung()

        with ProjektarbeitMapper() as mapper:
            return mapper.insert(projektarbeit)

    def get_all_projektarbeit(self):
        """ Wir geben alle Projektarbeiten aus """
        with ProjektarbeitMapper() as mapper:
            return mapper.find_all()

    """Urlaub"""
    def create_urlaub(self, person_id, start_datum, end_datum):
        """Urlaub anlegen."""

        urlaub = Urlaub()
        urlaub.set_id(1211)
        urlaub.set_person_id(person_id)
        urlaub.set_start_date(start_datum)
        urlaub.set_end_date(end_datum)
        urlaub.set_letzte_aenderung()
        """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""
        with UrlaubMapper() as mapper:
            return mapper.insert(urlaub)

    def get_all_urlaub(self):
        """Wir geben Urlaub von allen aus"""
        with UrlaubMapper() as mapper:
            return mapper.find_all()

    def get_urlaub_by_id(self, urlaub_id):
        """ Wir geben den Urlaub mit der angegebenen ID zurück """
        with UrlaubMapper() as mapper:
            return mapper.find_by_id(urlaub_id)

    def delete_urlaub_by_urlaub_id(self, urlaub_id):
        """ Wir löschen den Urlaub anhand der angegebenen Urlaub ID """
        with UrlaubMapper() as mapper:
            return mapper.delete(urlaub_id)

    def update_urlaub(self, urlaub):
        """ Wir aktualisieren den Urlaub und weißen letzte_aenderung neu zu"""
        urlaub.set_letzte_aenderung()

        with UrlaubMapper() as mapper:
            return mapper.update(urlaub)

    """Mitarbeiter"""
    def create_mitarbeiter_in_projekt(self, mitarbeiter, projekt, verkaufte_stunden):
            """Mitarbeiter in Projekt anlegen."""
            mitarbeiter_in_projekt = MitarbeiterInProjekt()
            mitarbeiter_in_projekt.set_person(mitarbeiter)
            mitarbeiter_in_projekt.set_projekt(projekt)
            mitarbeiter_in_projekt.set_verkaufte_stunden(verkaufte_stunden)
            mitarbeiter_in_projekt.set_letzte_aenderung()

            with MitarbeiterInProjektMapper() as mapper:
                return mapper.insert(mitarbeiter_in_projekt)

    def get_all_mitarbeiter_in_projekt(self):
        """Wir geben alle Mitarbeiter in einem Projekt aus"""
        with MitarbeiterInProjektMapper() as mapper:
            return mapper.find_all()

    def get_mitarbeiter_in_projekt_by_idd(self, person_idd):
        """ Wir geben die Mitarbeiter der jeweiligen Projekte mit der angegebenen ID zurück """
        with MitarbeiterInProjektMapper() as mapper:
            return mapper.find_by_id(person_idd)

    def get_person_by_person_id_and_projekt_by_projekt_id(self, person_idd, projekt_id):
        """ Wir geben die Person mit der angegebenen Person ID und das Projekt mit der angegebenen Projekt ID zurück """
        with MitarbeiterInProjektMapper() as mapper:
            return mapper.delete(person_idd, projekt_id)

    def get_projekt_by_id(self, projekt_id):
        """ Wir geben die Projekte mit der angegebenen ID zurück """
        with ProjektMapper() as mapper:
            return mapper.find_by_id(projekt_id)

    def get_all_projekte_by_mitarbeiter_id(self, person_id):
        """ Wir geben die Projekte mit der angegebenen ID zurück """
        with ProjektMapper() as mapper:
            return mapper.find_projektnamen(person_id)

    def get_all_aktivitaeten_by_projekt_id(self, projekt_id):
        """Alle Aktivitäten in einem Projekt ausgeben"""
        with AktivitaetMapper() as mapper:
            return mapper.find_all_aktivitaeten_by_projekt_id(projekt_id)

    def projekte_by_projektleiter(self, projektleiter):
        with ProjektMapper() as mapper:
            return mapper.projektleiter(projektleiter)


    def get_all_verkaufte_stunden_in_aktivitaet(self):
        """ Wir geben alle verkaufte_stunden_in_aktivitaet aus """
        with VerkaufteStundenInAktivitaetMapper() as mapper:
            return mapper.find_all()


    def create_verkaufte_stunden_in_aktivitaet(self, aktivitaet, mitarbeiter, gebuchte_stunden):
            """verkaufte_stunden_in_aktivitaet anlegen."""
            averkaufte_stunden = VerkaufteStundenInAktivitaet()
            averkaufte_stunden.set_aktivitaet(aktivitaet)
            averkaufte_stunden.set_person(mitarbeiter)
            averkaufte_stunden.set_gebuchte_stunden(gebuchte_stunden)
            averkaufte_stunden.set_letzte_aenderung()

            with VerkaufteStundenInAktivitaetMapper() as mapper:
                return mapper.insert(averkaufte_stunden)


    def get_sollzeit_by_id(self, projekt_id):
        """ Wir geben die Sollzeit mit der angegebenen ID zurück """
        with VerkaufteStundenInAktivitaetMapper() as mapper:
            return mapper.find_by_id(projekt_id)


    def get_mitarbeiteransicht_by_id(self, projekt_id):
        """ Wir geben die Mitarbeiteransicht mit der angegebenen ID zurück """
        with VerkaufteStundenInAktivitaetMapper() as mapper:
            return mapper.mitarbeiteransicht_find_by_id(projekt_id)


    def get_persoenliche_mitarbeiteransicht_by_id(self, person_id):
        """ Wir geben die persönliche Mitarbeiteransicht mit der angegebenen ID zurück """
        with VerkaufteStundenInAktivitaetMapper() as mapper:
            return mapper.persoenliche_mitarbeiteransicht_find_by_id(person_id)

    def get_projekte_by_projekt_id_and_person_id_buchen(self, person_id, projekt_id):
        """ Wir geben die Projekte mit der angegebenen Projekt und Personen ID zurück """
        with AktivitaetMapper() as mapper:
            return mapper.buchen_ansicht_frontend(person_id, projekt_id)

    def get_zeitintervallbuchung_by_id(self, projekt_id):
        """ Wir geben die Zeitintervallbuchung mit der angegebenen ID zurück """
        with ZeitintervallbuchungMapper() as mapper:
            return mapper.find_by_projekt_id(projekt_id)

    def create_zeitintervallbuchung(self, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit):
        """Eine Zeitintervallbuchung anlegen."""

        buchung = Zeitinverallbuchung()
        buchung.set_id(1211)
        buchung.set_projekt_id(projekt_id)
        buchung.set_person_id(person_id)
        buchung.set_aktivitaet_id(aktivitaet_id)
        buchung.set_zeitintervall(gearbeitete_zeit)
        buchung.set_letzte_aenderung()

        with ZeitintervallbuchungMapper() as mapper:
            return mapper.insert(buchung)


    """Kommen"""
    def create_kommen(self, person_id, start_kommen):
        """Ein Kommen anlegen."""
        kommen = Kommen()
        kommen.set_id(1211)
        kommen.set_person_id(person_id)
        kommen.set_start_kommen(start_kommen)
        kommen.set_letzte_aenderung()
        """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""

        with KommenMapper() as mapper:
            return mapper.insert(kommen)

    def get_all_kommen(self):
        """Wir geben Kommen von allen aus"""
        with KommenMapper() as mapper:
            return mapper.find_all()

    """Gehen"""
    def create_gehen(self, person_id, ende):
        """Gehen anlegen."""

        gehen = Gehen()
        gehen.set_id(1211)
        gehen.set_person_id(person_id)
        gehen.set_ende(ende)
        gehen.set_letzte_aenderung()
        """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""

        with GehenMapper() as mapper:
            return mapper.insert(gehen)

    def get_all_gehen(self):
        """Wir geben Gehen von allen aus"""
        with GehenMapper() as mapper:
            return mapper.find_all()

    """Ereignisbuchung"""
    def create_ereignisbuchung(self, kommen_id, gehen_id):
        """Ereignisbuchung anlegen."""

        ereignisbuchung = Ereignisbuchung()
        ereignisbuchung.set_id(1211)
        ereignisbuchung.set_kommen_id(kommen_id)
        ereignisbuchung.set_gehen_id(gehen_id)
        ereignisbuchung.set_letzte_aenderung()
        """ Kein Attribut wird vergeben, da datetime.now() ausgeführt und gespeichert wird"""

        with EreignisbuchungMapper() as mapper:
            return mapper.insert(ereignisbuchung)

    def get_all_ereignisbuchung(self):
        """Wir geben Ereignisbuchung von allen aus"""
        with EreignisbuchungMapper() as mapper:
            return mapper.find_all()