Модуль nginx mp4frag используется для http-стриминга

СБОРКА.
    Модуль можно взять здесь. github.com/inventos/OpenHttpStreamer
    nginx можно взять здесь: http://nginx.org/download/ и распаковать.
    В директории nginx выполните команду 
    
	./configure --add-module=<path to module>
	
    Безусловно Вы можете добавить другие параметры по Вашему запросу.
    После этого в директории с исходниками nginx выполните.
    
	make
	sudo make install
	
    Эта команда соберет nginx только с модулем mp4frag и установит его. Полный список параметров ищите в документации к 
nginx.

ПРОВЕРКА.
    Вам необходим какой-нибудь нефрагментированный mp4-файл (или файлы, сконвертированные из одного но с разным битрейтом)
для проверки работы модуля. 
    Используйте mp4frag для получения исходных структур данных.
    Use:
    
	mp4frag --src <mp4file> (--src <mp4file-other-bitrate> ...) --template.
	
    Команда создаст два файла - manifest.f4m and index. После этого перемещение исходных mp4-файлов запрещено без 
пересоздания индекса.

    Настройте Ваш сервер nginx. Параметры, которые должны присутствовать в конфигурационном файле записаны в файле
mp4frag.conf, а точные значения параметров зависят от той конфигурации, которая Вам необходима. Только параметр "location" 
должен быть установлен как в примере. Запустите nginx с новыми параметрами.
    Для тестирования создайте в директории nginx docroot директорию test_ohs. Положите туда файлы manifest.f4m и index, 
созданные на предыдущем шаге, проверьте чтобы пользователь, под которым запущен nginx может читать директорию, где 
расположены mp4 файлы. Настройка завершена.
    Проверьте работу, выполнив несколько http-запросов, например
    
	wget -O /dev/null "http://your-server-address/path/<qual_num>/Seg1-Frag<fragment-num>"
	
    где 
    <qual_num> - качество, нумерация начинается от нуля. Количество качеств определяется количеством исходных mp4-файлов.
    <fragment-num> - номер фрагмента, который вы запрашиваете, начиная от 0. Грубо - количество врагментов - это 
длительность ролика в секундах, деленная на четыре.
    Успешный запрос должен вернуть код ответа http 200. Если все так, Вы можете продолжить создание Вашей 
мультимедиа-системы, прочитав статью по адресу http://inventos.ru/OpenHttpStreamer.