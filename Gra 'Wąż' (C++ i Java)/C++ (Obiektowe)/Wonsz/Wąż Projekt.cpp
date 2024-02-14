#include <iostream>
#include <conio.h>
#include <cstdlib>
#include <ctime>
#include <windows.h>
#include <vector>


#define WIDTH 50
#define HEIGHT 25

using namespace std;

class Snake
{
private:
    COORD pos; //COORD definiuje współrzędne komórki znakowej w buforze ekranu konsoli
    int vel;
    char dir;
    int len;
    vector<COORD> body; //vector to struktura danych reprezentująca tablicę, umożliwia modyfikację rozmiaru tablicy w trakcie życia obiektu

public:
    Snake(COORD pos, int vel);

    void grow();
    void move_snake();
    void direction(char dir);

    vector<COORD> get_body();  

    bool collided1();
    bool collided2();
    bool eaten(COORD food);
    bool reset();

    COORD get_pos();
    HANDLE hOut; //do kolorow
};



class Food
{
private:
    COORD posy;

public:
    void gen_food();

    COORD get_pos();
};



Snake::Snake(COORD pos, int vel)
{
        this->pos = pos;
        this->vel = vel;

        dir = 'n'; //"none"
        len = 1;

        body.push_back(pos); //Dodaje nowy element na końcu kontenera vector
}

void Snake::direction(char dir) { this->dir = dir; }
void Snake::grow() { len++; }
COORD Snake::get_pos() { return pos; }

vector<COORD> Snake::get_body() { return body; }

void Snake::move_snake()
{
    switch (dir)
    {
    case 'u': pos.Y -= vel; break;
    case 'd': pos.Y += vel; break;
    case 'l': pos.X -= vel; break;
    case 'r': pos.X += vel; break;
    }

    body.push_back(pos);
    if (body.size() > len) body.erase(body.begin());
}

bool Snake::collided1()         //uwzględniając ściany
{
    if (pos.X < 1 || pos.X > WIDTH - 2 || pos.Y < 1 || pos.Y > HEIGHT - 2)      // kolizja ściana
    {
        return true;
    }

    for (int i = 0; i < len - 1; i++)           // kolizja ogon
    {
        if (pos.X == body[i].X && pos.Y == body[i].Y) return true;
    }
    return false;
}

bool Snake::collided2()         //nie uwzględniając ścian
{
    if (pos.X >= WIDTH) pos.X = 0; else if (pos.X < 0) pos.X = WIDTH - 1;       //przechodzenie przez ściany
    if (pos.Y >= HEIGHT) pos.Y = 0; else if (pos.Y < 0) pos.Y = HEIGHT - 1;

    for (int i = 0; i < len - 1; i++)
    {
        if (pos.X == body[i].X && pos.Y == body[i].Y) return true;
    }
    return false;
}
bool Snake::reset()             //resetowanie ustawień do stanu początkowego
{
    len = 1;
    pos.X = WIDTH / 2; pos.Y = HEIGHT / 2;
    dir = 'n';
    vel = 1;
    while (body.size() > 0)
        {
            body.erase(body.begin());
        }
    return true;
}

bool Snake::eaten(COORD food)       //sprawdzenie czy wąż zjadł owoc
{
    if (pos.X == food.X && pos.Y == food.Y) return true;
    return false;
}




void Food::gen_food()       //generowanie miejsca pojawienia się owoca
{
    posy.X = rand() % WIDTH ;
    posy.Y = rand() % HEIGHT ;
    if (posy.X < 10) { posy.X += 7; }
    if (posy.X > 49) { posy.X -= 7; }
    if (posy.Y < 5) { posy.Y += 5; }
    if (posy.Y > 24) { posy.Y -= 5; }
}

COORD Food::get_pos() { return posy; }

Snake snake({ WIDTH / 2, HEIGHT / 2 }, 1);
Food food;

int score;

void Start()
{
    system("cls");
    cout << endl << "\t Witam w grze WONSZ" << endl << endl << endl;
    cout << "\t Nacisnij 'g', aby GRAC" << endl << endl;
    cout << "\t Nacisnij 'k', aby zmienic KOLORY" << endl << endl;
    cout << "\t Nacisnij 'i', aby zobaczyc INSTRUKCJE GRY." << endl << endl;
    cout << "\t Nacisnij 'w', aby WYJSC" << endl << endl << endl << endl;
    cout << "\t Poprzedni wynik w tej sesji: " << score << endl;
}

void plansza()
{
    COORD snake_pos = snake.get_pos();
    COORD food_pos = food.get_pos();

    vector<COORD> snake_body = snake.get_body();

    cout << " WYNIK : " << score << "\n\n";

    for (int i = 0; i < HEIGHT; i++)        //tworzenie obrysu planszy gdzie się będzie rozgrywać gra
    {
        cout << "\t\t#";
        for (int j = 0; j < WIDTH - 2; j++)
        {
            if (i == 0 || i == HEIGHT - 1) cout << '#';

            else if (i == snake_pos.Y && j + 1 == snake_pos.X) cout << '0';     //tworzenie głowy
            else if (i == food_pos.Y && j + 1 == food_pos.X) cout << '&';       //tworzenie owocka

            else
            {
                bool isBodyPart = false;
                for (int k = 0; k < snake_body.size() - 1; k++)
                {   
                    if (i == snake_body[k].Y && j + 1 == snake_body[k].X)
                    {
                        cout << 'o';               //tworzenie reszty ciała
                        isBodyPart = true;
                        break;
                    }
                }
                if (!isBodyPart) cout << ' ';
            }
        }
        cout << "#\n";
    }
}




void Polowanie()
{
    srand(time(NULL));
    plansza();
    food.gen_food();
}



void Tryb1()
{
    system("cls");          //czyszczenie okna
    srand(time(NULL));      //powoduje że owoce będą co rozgrywkę pojawiały się w innych miejscach a nie w tych samych
    score = 0;

    food.gen_food();

    bool game_over = false;

    while (!game_over)
    {
        plansza();

        if (_kbhit())            //sprawdza czy w buforze klawiatury znajduje się jakaś dana do odczytania
        {
            switch (_getch())    //pobranie klawisza z klawiatury
            {
            case 'w': snake.direction('u'); break;
            case 'a': snake.direction('l'); break;
            case 's': snake.direction('d'); break;
            case 'd': snake.direction('r'); break;
            }
        }

        if (snake.collided1())   //w tym trybie spotkanie ze ścianą oraz własnym ogonem
        {
            game_over = true;
            snake.reset();
            Start();
        }

        if (snake.eaten(food.get_pos()))
        {
            food.gen_food();
            snake.grow();
            score = score + 10;
        }

        snake.move_snake();

        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), { 0, 0 }); //ustawia pozycję kursora

    }
}

void Tryb2()
{
    system("cls");
    srand(time(NULL));
    score = 0;

    food.gen_food();

    bool game_over = false;

    while (!game_over)
    {
        plansza();

        if (_kbhit())
        {
            switch (_getch())
            {
            case 'w': snake.direction('u'); break;
            case 'a': snake.direction('l'); break;
            case 's': snake.direction('d'); break;
            case 'd': snake.direction('r'); break;
            }
        }

        if (snake.collided2())    //w tym trybie spotkanie z własnym ogonem
        {
            game_over = true;
            snake.reset();
            Start();
        }

        if (snake.eaten(food.get_pos()))
        {
            food.gen_food();
            snake.grow();
            score = score + 10;
        }

        snake.move_snake();

        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), { 0, 0 });

    }
}

void Tryb3()
{
    system("cls");

    bool game_over = false;
    score = 0;

    while (!game_over)
    {
        Polowanie();

        if (_kbhit())
        {
            switch (_getch())
            {
            case 'w': snake.direction('u'); break;
            case 'a': snake.direction('l'); break;
            case 's': snake.direction('d'); break;
            case 'd': snake.direction('r'); break;
            }
        }

        if (snake.collided2())  //w tym trybie spotkanie z własnym ogonem
        {
            game_over = true;
            snake.reset();
            Start();
        }

        if (snake.eaten(food.get_pos()))
        {
            //food.gen_food();
            snake.grow();
            score = score + 10;
        }

        snake.move_snake();

        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), { 0, 0 });

    }
}

void Wybor()
{
    system("cls");
    cout << endl << "\t Jaki tryb wybierasz? " << endl << endl;
    cout << "\t 1. Klasyczny " << endl;
    cout << "\t 2. Bez scian " << endl;
    cout << "\t 3. Poscig " << endl << endl;
    cout << "\t Nacisnij 'm', aby wrocic do MENU." << endl;
    string s;
    cin >> s;
    if (s == "1")
    {
        Tryb1();
    }
    else if (s == "2")
    {
        Tryb2();
    }
    else if (s == "3")
    {
        Tryb3();
    }
    else if (s == "m")
    {
        Start();
    }
    else
        Wybor();
}

void InstrukcjaObslugi()
{
    system("cls");
    cout << "\t _____________________________________________________________" << endl;
    cout << endl << "\t Poruszasz sie za pomoca AWSD." << endl << endl;
    cout << "\t Zdobywaj jak najwiecej owocow." << endl << endl;
    cout << "\t Nie jedz wlasnego ogona." << endl << endl << endl;
    cout << "\t Tryb 'Klasyczny' posiada kolizje z scianami." << endl << endl;
    cout << "\t Tryb 'Bez scian' nie posiada kolizji ze scianami." << endl << endl;
    cout << "\t Tryb 'Poscig' nie posiada kolizji ze scianami oraz powoduje zmiane miejsca polozenia owoca co chwile" << endl << endl << endl;
    cout << "\t UWAGA!!!" << endl << "\t Kiedy nasz protagonista bedzie posiadal wiecej niz 3 dlugosci, gwaltowne zawracanie usmierci go na miejscu." << endl << "\t Wynika to z smutnej natury wezy :( Jesli go szanujesz, to probuj tego nie robic." << endl << endl << endl;
    cout << "\t Nacisnij 'm', aby wrocic do MENU." << endl;
    cout << "\t _____________________________________________________________" << endl;
    string s;
    cin >> s;
    if (s == "m")
        Start();
    else
        InstrukcjaObslugi();
}

void Kolory() //zmiany kolorow tla konsoli
{
    system("cls");
    cout << endl << "\t Jaki chcesz miec kolor tla? " << endl << endl;
    cout << "\t 1. Czerwony " << endl << endl;
    cout << "\t 2. Niebieski " << endl << endl;
    cout << "\t 3. Zielony " << endl << endl;
    cout << "\t 4. Bialy" << endl << endl;
    cout << "\t 5. Czarny" << endl << endl << endl;
    cout << "\t Nacisnij 'm' zeby wrocic do MENU" << endl;
    string k;
    cin >> k;
    snake.hOut = GetStdHandle(STD_OUTPUT_HANDLE);
    if (k == "1")
        SetConsoleTextAttribute(snake.hOut, BACKGROUND_RED);
    else if (k == "2")
        SetConsoleTextAttribute(snake.hOut, BACKGROUND_BLUE);
    else if (k == "3")
        SetConsoleTextAttribute(snake.hOut, BACKGROUND_GREEN | FOREGROUND_INTENSITY);
    else if (k == "4")
        SetConsoleTextAttribute(snake.hOut, BACKGROUND_GREEN | BACKGROUND_RED | BACKGROUND_BLUE);
    else if (k == "5") { //ustawienie tla konsoli na czarny i tekstu na bialy [w przeciwnym wypadku wszystko bedzie czarne i nieczytelne]
        SetConsoleTextAttribute(snake.hOut, 0);
        SetConsoleTextAttribute(snake.hOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE);
    }
    else if (k == "m")
        Start();
    else
        Kolory();

}


int main()
{
    bool koniec = false;
    do {
        Start();
        string input;
        cin >> input;
        if (input == "g")
            Wybor();
        else if (input == "i")
            InstrukcjaObslugi();
        else if (input == "k")
            Kolory();
        else if (input == "w")
            koniec = true;
    } while (koniec == false);

    return 0;
}
