from bo.Ereignis import Ereignis

class Kommen(Ereignis):

    def __init__(self, zeitpunkt,aktivitaet, person):
        super().__init__(zeitpunkt, aktivitaet, person)
        self.__zeitpunkt = zeitpunkt
        self.__person = aktivitaet
        self.__aktivitaet = person

    def set_start(self, value):
        self.__zeitpunkt = value

    def get_start(self):
        return self.__zeitpunkt
