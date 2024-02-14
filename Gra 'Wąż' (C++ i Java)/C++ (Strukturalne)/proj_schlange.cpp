#include <iostream>
#include <conio.h> //getch i kbhit
#include <windows.h> //sleep
#include <cstdlib> //rand i srand
#include <ctime> //do srand
using namespace std;

bool gameOver;
bool koniec;
const int szer = 30;
const int wys = 15;
int x, y, owocX, owocY, wynik;
int ogonX[100], ogonY[100];
int DlOgon;
enum eDirecton { STOP = 0, LEFT, RIGHT, UP, DOWN }; //do poruszania
eDirecton dir;
HANDLE hOut; //do kolorow

void Start()
{
    system("cls");
    cout << endl << "\t Witam w grze DIE SCHLANGE" << endl << endl<<endl;
    cout << "\t Nacisnij 'g', aby GRAC" << endl << endl;
    cout << "\t Nacisnij 'k', aby zmienic KOLORY" << endl << endl;
    cout << "\t Nacisnij 'i', aby zobaczyc INSTRUKCJE GRY." << endl << endl;
    cout << "\t Nacisnij 'w', aby WYJSC" << endl << endl << endl << endl;
    cout << "\t Poprzedni wynik w tej sesji: " << wynik << endl;
}

void Setup()
{
    srand(time(NULL)); //losowanie do owocow
    gameOver = false;
    koniec = false;
    dir = STOP; //brak ruchu na poczatku
    x = szer / 2;  //punkty ktore daja cel na srodek
    y = wys / 2;
    owocX = rand() % szer;
    owocY = rand() % wys;
    wynik = 0;
    DlOgon = 0;
}
void Draw() //tworzenie mapy i scian
{
    system("cls");
    for (int i = 0; i < szer + 2; i++)
        cout << "#";
    cout << endl;

    for (int i = 0; i < wys; i++)
    {
        for (int j = 0; j < szer; j++)
        {
            if (j == 0)
                cout << "#";
            if (i == y && j == x) //ustawienie snake'a na srodku
                cout << "O";
            else if (i == owocY && j == owocX)
                cout << "&";
            else
            {
                bool print = false;
                for (int k = 0; k < DlOgon; k++)
                {
                    if (ogonX[k] == j && ogonY[k] == i)
                    {
                        cout << "o";
                        print = true;
                    }
                }
                if (!print)
                    cout << " ";
            }
            if (j == szer - 1)
                cout << "#";
        }
        cout << endl;
    }

    for (int i = 0; i < szer + 2; i++)
        cout << "#";
    cout << endl;
    cout << "Wynik:" << wynik << endl;
}
void Input() //przypisanie klawiszy do poruszania
{
    if (_kbhit()) //sprawdza czy w buforze klawiatury znajduje sie jakas dana do odczytania
    {
        switch (_getch()) //pobranie klawisza
        {
        case 'a':
            dir = LEFT;
            break;
        case 'd':
            dir = RIGHT;
            break;
        case 'w':
            dir = UP;
            break;
        case 's':
            dir = DOWN;
            break;
        case 'q':
            gameOver = true;
            break;
        }
    }
}
void Logic() //tworzenie logiki weza
{
    int prevX = ogonX[0];
    int prevY = ogonY[0];
    int prev2X, prev2Y;
    ogonX[0] = x;
    ogonY[0] = y;
    for (int i = 1; i < DlOgon; i++)
    {
        prev2X = ogonX[i];
        prev2Y = ogonY[i];
        ogonX[i] = prevX;
        ogonY[i] = prevY;
        prevX = prev2X;
        prevY = prev2Y;
    }
    switch (dir)
    {
    case LEFT:
        x--;
        break;
    case RIGHT:
        x++;
        break;
    case UP:
        y--;
        break;
    case DOWN:
        y++;
        break;
    default:
        break;
    }

    if (x >= szer) x = 0; else if (x < 0) x = szer - 1; //przechodzenie przez sciany
    if (y >= wys) y = 0; else if (y < 0) y = wys - 1;

    for (int i = 0; i < DlOgon; i++)
        if (ogonX[i] == x && ogonY[i] == y) { //zjedzenie swojego ogona
            gameOver = true;
            Start();
        }
    if (x == owocX && y == owocY) //zjedzenie owoca
    {
        wynik += 100;
        owocX = rand() % szer;
        owocY = rand() % wys;
        DlOgon++;
    }
}

void Logic2() //tworzenie logiki poruszania sie weza v2
{
    int prevX = ogonX[0];
    int prevY = ogonY[0];
    int prev2X, prev2Y;
    ogonX[0] = x;
    ogonY[0] = y;
    for (int i = 1; i < DlOgon; i++)
    {
        prev2X = ogonX[i];
        prev2Y = ogonY[i];
        ogonX[i] = prevX;
        ogonY[i] = prevY;
        prevX = prev2X;
        prevY = prev2Y;
    }
    switch (dir)
    {
    case LEFT:
        x--;
        break;
    case RIGHT:
        x++;
        break;
    case UP:
        y--;
        break;
    case DOWN:
        y++;
        break;
    default:
        break;
    }
    if (x > szer || x < 0 || y > wys || y < 0) { //spotkanie weza ze sciana
        gameOver = true;
        Start();
    }

    for (int i = 0; i < DlOgon; i++)
        if (ogonX[i] == x && ogonY[i] == y) { //zjedzenie swojego ogona
            gameOver = true;
            Start();
        }
    if (x == owocX && y == owocY) //zjedzenie owoca
    {
        wynik += 100;
        owocX = rand() % szer;
        owocY = rand() % wys;
        DlOgon++;
    }
}




void Opcje1()
{
    system("cls"); //czyszczenie konsoli
    cout << endl << "\t Jaki poziom trudnosci? " << endl << endl;
    cout << "\t 1. Latwy " << endl << endl;
    cout << "\t 2. Sredni " << endl << endl;
    cout << "\t 3. Trudny " << endl << endl << endl;
    string c; //uzycie stringa wyklucza wpisanie innego znaku/liczby niz wymaga co chroni przed bledami
    cin >> c;
    Setup();
    while (!gameOver)
    {
        Draw();
        Input();
        Logic();
        if (c == "1")
            Sleep(100); //szybkosc odswiezania = szybkosc poruszania
        else if (c == "2")
            Sleep(50);
        else if (c == "3")
            Sleep(10);
        else
            Opcje1(); //zabezpieczenie gdy ktos wpisze cos innego niz wymaga program - ponawia zapytanie w danym segmencie
    }
}
void Opcje2()
{
    system("cls");
    cout << endl << "\t Jaki poziom trudnosci? " << endl << endl;
    cout << "\t 1. Latwy " << endl << endl;
    cout << "\t 2. Sredni " << endl << endl;
    cout << "\t 3. Trudny " << endl << endl;
    string c;
    cin >> c;
    Setup();
    while (!gameOver)
    {
        Draw();
        Input();
        Logic2();
        if (c == "1")
            Sleep(100);
        else if (c == "2")
            Sleep(50);
        else if (c == "3")
            Sleep(10);
        else
            Opcje2();
    }
}

void MenuGry()
{
    system("cls");

    cout << endl << "\t Wybierz tryb: " << endl << endl;
    cout << "\t 1. Bez kolizji" << endl << endl;
    cout << "\t 2. Klasyczny" << endl << endl << endl;
    cout << "\t Nacisnij 'm' aby wrocic" << endl;
    string a{};
    cin >> a;

    if (a == "1")
        Opcje1();
    else if (a == "2")
        Opcje2();
    else if (a == "m")
        Start();
    else
        MenuGry();
}

void InstrukcjaObslugi()
{
    system("cls");
    cout << endl << "\t W GRZE WYSTEPUJE NADMIERNA EPILEPSJA - GRASZ NA WLASNE RYZYKO." << endl;
    cout << "\t _____________________________________________________________" << endl;
    cout << endl << "\t Poruszasz sie za pomoca AWSD." << endl << endl;
    cout << "\t Nacisnij klawisz 'q', aby WYJSC z gry w dowolnym momencie." << endl << endl;
    cout << "\t Tryb 'Klasyczny' to tryb interakcji z otoczeniem." << endl << endl;
    cout << "\t Natomiast tryb 'Bez kolizji' to tryb bez interakcji z otoczeniem (mozesz przechodzic przez sciany)." << endl << endl;
    cout << "\t Sa 3 poziomy trudnosci - kazdy specjalizuje sie w szybkosci rozgrywki." << endl << endl;
    cout << "\t Nie jedz wlasnego ogona." << endl << endl << endl;
    cout << "\t UWAGA" << endl << "\t Kiedy nasz protagonista bedzie posiadal wiecej niz 3 dlugosci, gwaltowne zawracanie usmierci go na miejscu."<<endl<<"\t Wynika to z smutnej natury wezy :( Wiec jesli go szanujesz, to probuj tak nie robic." << endl << endl << endl;
    cout << "\t Nacisnij 'm', aby wrocic do MENU." << endl;
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
    hOut = GetStdHandle(STD_OUTPUT_HANDLE);
    if (k == "1")
        SetConsoleTextAttribute(hOut, BACKGROUND_RED);
    else if (k == "2")
        SetConsoleTextAttribute(hOut, BACKGROUND_BLUE);
    else if (k == "3")
        SetConsoleTextAttribute(hOut, BACKGROUND_GREEN | FOREGROUND_INTENSITY);
    else if (k == "4")
        SetConsoleTextAttribute(hOut, BACKGROUND_GREEN | BACKGROUND_RED | BACKGROUND_BLUE);
    else if (k == "5") { //ustawienie tla konsoli na czarny i tekstu na bialy [w przeciwnym wypadku wszystko bedzie czarne i nieczytelne]
        SetConsoleTextAttribute(hOut, 0);
        SetConsoleTextAttribute(hOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE);
    }
    else if (k == "m")
        Start();
    else
        Kolory();

}



int main()
{
    do {
        Start();
        string input;
        cin >> input;
        if (input == "g")
        {
            MenuGry();
        }
        else if (input == "i")
            InstrukcjaObslugi();
        else if (input == "k")
            Kolory();
        else if (input == "w")
            koniec = true;
    } while (koniec == false);

    return 0;
}