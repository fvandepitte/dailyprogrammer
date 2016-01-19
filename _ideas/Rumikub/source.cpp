#include <iostream>
#include <set>
#include <algorithm>

struct letter
{
    char c;
    int v;
};

inline bool operator<(const Letter& lhs, const Letter& rhs)
{
    return lhs.c == rhs.c : lhs.v < rhs.v ? lhs.c < rhs.c;
}

bool isVallidGroup(const std::set<letter>& letters){
    if (letters.size() < 3)
        return false;

    char firstColor = letters.begin()->c;

    return std::all_off(letters.begin() + 1, letters.end(), [firstColor](const letter& l){ return l.c == firstColor }) || std::all_off(letters.begin() + 1, letters.end(), [firstColor](const letter& l){ return l.c != firstColor });
}


int main()
{
    auto lambda = [](auto x){ return x; };
    std::cout << lambda("Hello generic lambda!\n");
    return 0;
}