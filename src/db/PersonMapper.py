from bo.Person import Person
from db.Mapper import Mapper

"""
 * @author [Aykut Demir](https://github.com/AykutDemirr)
 * @author [Dennis Kühnberger](https://github.com/Dennis-248)
 * @author [Nicola Pany](https://github.com/NicolaPany)
 * @author [Talha Yildirim](https://github.com/talha16)
"""

class PersonMapper(Mapper):

    def __init__(self):
        super().__init__()

    def find_all(self):
        """ Wir suchen alle Personen """
        result = []
        cursor = self._cnx.cursor()
        cursor.execute("SELECT * FROM Person")
        person_daten = cursor.fetchall()

        for (person_id, vorname, nachname,  mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung) in person_daten:
            person = Person()
            person.set_vorname(vorname)
            person.set_nachname(nachname)
            person.set_benutzername(benutzername)
            person.set_mail_adresse(mail_adresse)
            person.set_urlaubstage(urlaubstage)
            person.set_ueberstunden(ueberstunden)
            person.set_id(person_id)
            person.set_letzte_aenderung_fuer_get_methode(letzte_aenderung)
            result.append(person)
            print(result)

        self._cnx.commit()
        cursor.close()
        print(result)
        return result


    def find_by_id(self, id):
        """ Wir suchen die Person mit der jeweiligen ID """
        result = None

        cursor = self._cnx.cursor()
        command = "SELECT * FROM Person WHERE person_id={0}".format(id)
        cursor.execute(command)
        person_daten = cursor.fetchall()

        try:
            (person_id, vorname, nachname,  mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung) = person_daten[0]
            person = Person()
            person.set_vorname(vorname)
            person.set_nachname(nachname)
            person.set_benutzername(benutzername)
            person.set_mail_adresse(mail_adresse)
            person.set_urlaubstage(urlaubstage)
            person.set_ueberstunden(ueberstunden)
            person.set_id(person_id)
            person.set_letzte_aenderung_fuer_get_methode(letzte_aenderung)
            result = person
        except IndexError:
            """ Tritt auf, wenn es beim SELECT-Aufruf kein Ergebnis liefert, sondern person_daten leer ist """
            result = None

        self._cnx.commit()
        cursor.close()
        print(result)
        return result

    def find_by_benutzername(self, benutzer):
        """ Wir suchen die Person mit dem jeweiligen Benutzername """
        result = None

        cursor = self._cnx.cursor()
        command = "SELECT * FROM Person WHERE benutzername='{}'".format(benutzer)
        cursor.execute(command)
        person_daten = cursor.fetchall()

        try:
            (person_id, vorname, nachname,  mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung) = person_daten[0]
            person = Person()
            person.set_vorname(vorname)
            person.set_nachname(nachname)
            person.set_benutzername(benutzername)
            person.set_mail_adresse(mail_adresse)
            person.set_urlaubstage(urlaubstage)
            person.set_ueberstunden(ueberstunden)
            person.set_id(person_id)
            person.set_letzte_aenderung_fuer_get_methode(letzte_aenderung)
            result = person
        except IndexError:
            """ Tritt auf, wenn es beim SELECT-Aufruf kein Ergebnis liefert, sondern person_daten leer ist """
            result = None

        self._cnx.commit()
        cursor.close()
        print(result)
        return result


    def delete(self, person):
        """Löschen der Daten eines Person-Objekts aus der Datenbank.

        :param person das aus der DB zu löschende "Objekt"
        """
        cursor = self._cnx.cursor()

        command = "DELETE FROM Person WHERE person_id={}".format(person)
        cursor.execute(command)

        self._cnx.commit()
        cursor.close()
        return person

    def insert(self, person):
        """ Einfügen eines neuen Person-Objekts in die Datenbank.
        parameter: Person Instanz die in der Datenbank gespeichert werden soll
        return: Die Person Instanz mit korrigierter bzw. inkrementierte ID
        """

        cursor = self._cnx.cursor()
        cursor.execute("SELECT MAX(person_id) AS maxid FROM Person ")
        tuples = cursor.fetchall()

        for (maxid) in tuples:
            person.set_id(maxid[0] + 1)


        """ Hier wird die Person Instanz in die Datenbank mit dem Insert Befehl gespeichert """
        command = "INSERT INTO Person (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
        data = (person.get_id(), person.get_vorname(), person.get_nachname(), person.get_mail_adresse(), person.get_benutzername(), person.get_urlaubstage(), person.get_ueberstunden(), person.get_letzte_aenderung())
        cursor.execute(command, data)

        self._cnx.commit()
        cursor.close()

        return person

    def update(self, person):
        """Wiederholtes Schreiben eines Personen-Objekts in die Datenbank.
        :param person das Objekt, das in die DB geschrieben werden soll
        """
        cursor = self._cnx.cursor()
        command = "UPDATE Person " + "SET vorname=%s, nachname=%s, mail_adresse=%s, urlaubstage=%s, letzte_aenderung=%s WHERE person_id=%s"
        data = (person.get_vorname(), person.get_nachname(), person.get_mail_adresse(), person.get_urlaubstage(), person.get_letzte_aenderung(), person.get_id())
        cursor.execute(command, data)

        self._cnx.commit()
        cursor.close()


""" Testing """
if __name__ == '__main__':
    with PersonMapper() as mapper:
        result = mapper.find_all()


    with PersonMapper() as mapper:
        result = mapper.find_by_id(5)
        print(result.get_vorname())
