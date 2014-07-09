#include <iostream>

using namespace std;

class Base {
public:
    int data;
    virtual ~Base() {}
};

class D1 : public Base {
public:
//    typedef Base parent;
    
    virtual ~D1() {}
};

class D2 : public Base {
public:
    virtual ~D2() {}
};

class D3 : public D1, public D2 {
public:
    virtual ~D3() {}

//    void setData(int i) { data = i; }
//     void setData1(int i) { D1::data = i; }
//     void setData2(int i) { D2::data = i; }

// //    int getData() { return data; }
//     int getData1() { return D1::data; }
//     int getData2() { return D2::data; }
};

void f1() {
    D3 d3;
    Base &base = dynamic_cast<D1&>(d3);
    // d3.D1::data = 123;
    // d3.D2::data = 456;

    cout << sizeof(D3) << endl;
//    cout << d3.D1::data << ',' << d3.D2::data << endl;

}

// void f2() {
//     D3 d3;

//     // d3.setData(987);
//     // cout << d3.getData1() << ',' << d3.getData2() << endl;

//     d3.setData1(123);
//     d3.setData2(234);
//     cout << d3.getData1() << ',' << d3.getData2() << endl;
// }

int main(int argc, char *argv[]) {
    f1();
//    f2();
    return 0;
}
