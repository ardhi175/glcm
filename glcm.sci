//=============================================================================
//  Fungsi GLCM v1
//  Authors : M. Ardhi K & Eli Ermawati (2020)
//=============================================================================

function [GLCM0,GLCM45,GLCM90,GLCM135]=glcm(F,pembagiL13,pembagiL8); 
    //      Membentuk 4 matriks GLCM, masing-masing untuk sudut 0,45,90,135 derajat dengan jarak ketetanggaan 1 piksel
    //
    //      Syntax 
    //          [GLCM0,GLCM45,GLCM90,GLCM135]=glcm(F,div1,div2)
    //
    //      Parameters 
    //          F : matriks grayscale yang akan dihitungkan matriks GLCM nya
    //          div1 : pembagi matriks GLCM, berupa bilangan bulat/integer positif. Ukuran maksimum matriks GLCM adalah 256 x 256 = 65536. Misal div1 = 4, maka proses pencarian pola pasangan piksel berdasarkan matriks GLCM akan dibagi menjadi 4 bagian, yang masing-masing bagian terdiri dari 65536/4=16384
    //          div2 : pembagi matriks yang berisi daftar pola pasangan piksel di matriks F. Nilai div2 berupa bilangan bulat/integer positif. 
    //
    //      Description
    //          Fungsi ini menghasilkan 4 matriks GLCM, masing-masing untuk sudut 0,45,90,135 derajat dengan jarak ketetanggaan 1 piksel. Untuk mengantisipasi kemungkinan komputer mengalami "hang" ketika menghitung matriks GLCM yang disebabkan habisnya ruang kosong di memory, maka disediakan 2 parameter tambahan untuk membagi-bagi proses pembentukan matriks GLCM sehingga ruang kosong di memory tidak sampai habis. Dengan begitu, proses penghitungan tetap dapat berjalan sampai selesai dan komputer tidak mengalami "hang". Sebagai contoh, untuk komputer dengan memory 10GB dapat dicoba untuk memberikan nilai parameter div1=4 sementara untuk div2, menyesuaikan ukuran matriks F. Jika ukuran matriks F adalah nxm, maka dapat dicoba untuk memberikan nilai parameter pembagiL8 sedemikian rupa sehingga (n.m/div2) bernilai sekitar 50. Kedua nilai parameter yang diberikan dalam contoh tersebut bukan ketentuan yang sudah baku, karena performa penghitungan bergantung pada kondisi komputer yang digunakan, baik dari spesifikasi hardware (processor, memory, storage) maupun kondisi sistem operasi ketika sedang digunakan untuk menghitung GLCM. Setiap pengguna dapat mencoba-coba berbagai nilai kedua parameter untuk menentukan kedua nilai yang cocok dengan komputernya masing-masing.
    //
    //     Authors
    //          M. Ardhi K & Eli Ermawati
    
    rhs=argn(2);
    // Error Checking
    if rhs <>3 ; error("Expect 3 arguments : grayscale matrix, divider 1, divider 2"); end 
    
    [Nx,Ny]=size(F); 
    L1=unique(F)';
    nL1=size(L1,"*");

    //-----------membuat matriks baris berisi kombinasi pixel arah 0,45,90,135 derajat berjarak 1 pixel dari matriks F, hasilnya disimpan dalam matriks L8-------------

        //arah 0 derajat
    L40=zeros(1,Nx*(Ny-1));
    L50=string(zeros(1,Nx*(Ny-1)));
    L50(1:Nx*(Ny-1))="+";
    L60=zeros(1,Nx*(Ny-1));
    for i=1:Nx
        L40((Ny-1)*(i-1)+1:(Ny-1)*i)=F(i,1:(Ny-1));
        L60((Ny-1)*(i-1)+1:(Ny-1)*i)=F(i,2:Ny);
    end
    L40string=string(L40);
    L60string=string(L60);
    L70=[L40string;L50;L60string];
    nL70=size(L70,"*");
    L80=string(zeros(1,nL70));
    L80=strcat(L70, "", "r");
    nL80=size(L80,"*");

        //arah 45 derajat
    L445=zeros(1,(Nx-1)*(Ny-1));
    L545=string(zeros(1,(Nx-1)*(Ny-1)));
    L545(1:(Nx-1)*(Ny-1))="+";
    L645=zeros(1,(Nx-1)*(Ny-1));
    for i=2:Nx
        L445((Ny-1)*(i-2)+1:(Ny-1)*(i-1))=F(i,1:(Ny-1));
        L645((Ny-1)*(i-2)+1:(Ny-1)*(i-1))=F(i-1,2:Ny);
    end
    L445string=string(L445);
    L645string=string(L645);
    L745=[L445string;L545;L645string];
    nL745=size(L745,"*");
    L845=string(zeros(1,nL745));
    L845=strcat(L745, "", "r");
    nL845=size(L845,"*");

        //arah 90 derajat
    L490=zeros(1,(Nx-1)*Ny);
    L590=string(zeros(1,(Nx-1)*Ny));
    L590(1:(Nx-1)*Ny)="+";
    L690=zeros(1,(Nx-1)*Ny);
    for i=2:Nx
        L490((Ny)*(i-2)+1:Ny*(i-1))=F(i,1:Ny);
        L690((Ny)*(i-2)+1:Ny*(i-1))=F(i-1,1:Ny);
    end
    L490string=string(L490);
    L690string=string(L690);
    L790=[L490string;L590;L690string];
    nL790=size(L790,"*");
    L890=string(zeros(1,nL790));
    L890=strcat(L790, "", "r");
    nL890=size(L890,"*");

        //arah 135 derajat
    L4135=zeros(1,(Nx-1)*(Ny-1));
    L5135=string(zeros(1,(Nx-1)*(Ny-1)));
    L5135(1:(Nx-1)*(Ny-1))="+";
    L6135=zeros(1,(Nx-1)*(Ny-1));
    for i=2:Nx
        L4135((Ny-1)*(i-2)+1:(Ny-1)*(i-1))=F(i,2:Ny);
        L6135((Ny-1)*(i-2)+1:(Ny-1)*(i-1))=F(i-1,1:(Ny-1));
    end
    L4135string=string(L4135);
    L6135string=string(L6135);
    L7135=[L4135string;L5135;L6135string];
    nL7135=size(L7135,"*");
    L8135=string(zeros(1,nL7135));
    L8135=strcat(L7135, "", "r");
    nL8135=size(L8135,"*");
    //-----------akhir pembuatan matriks baris berisi kombinasi pixel arah 0,45,90,135 derajat berjarak 1 pixel dari matriks F, hasilnya disimpan dalam matriks L8-------------

    //-----------membuat matriks baris berisi pasangan pixel yang akan dicari di matriks L8----------
    p=size(L1,"*");
    L9=zeros(1,p*p);
    L10=string(zeros(1,p*p));
    L10(1:p*p)="+";
    L11=zeros(1,p*p);
    for i=1:p
        L9(p*(i-1)+1:p*i)=L1(i);
        L11(p*(i-1)+1:p*i)=L1(1:p);
    end
    L9string=string(L9);
    L11string=string(L11);
    L12=[L9string;L10;L11string];
    nL12=size(L12,"*");
    L13=string(zeros(1,nL12));
    L13=strcat(L12, "", "r");
    nL13=size(L13,"*");
    //-----------akhir pembuatan matriks baris berisi pasangan pixel yang akan dicari di matriks L8----------

    //------------AWAL PEMBENTUKAN MATRIKS GLCM------------------------------ 
    nb0=zeros(1,nL13);
    nb45=zeros(1,nL13);
    nb90=zeros(1,nL13);
    nb135=zeros(1,nL13);

    GLCM0=zeros(p,p);
    GLCM45=zeros(p,p);
    GLCM90=zeros(p,p);
    GLCM135=zeros(p,p);

    rentangL13=(nL13-modulo(nL13,pembagiL13))/pembagiL13;
    rentangL80=(nL80-modulo(nL80,pembagiL8))/pembagiL8;
    rentangL845=(nL845-modulo(nL845,pembagiL8))/pembagiL8;
    rentangL890=(nL845-modulo(nL890,pembagiL8))/pembagiL8;
    rentangL8135=(nL845-modulo(nL8135,pembagiL8))/pembagiL8;

    for i=1:pembagiL8
        for j=1:pembagiL13
            if i==pembagiL8
                akhirrentangL80=nL80;
                akhirrentangL845=nL845;
                akhirrentangL890=nL890
                akhirrentangL8135=nL8135;;
            else
                akhirrentangL80=i*rentangL80;
                akhirrentangL845=i*rentangL845;
                akhirrentangL890=i*rentangL890;
                akhirrentangL8135=i*rentangL8135;
            end    
            if j==pembagiL13
                akhirrentangL13=nL13;
            else
                akhirrentangL13=j*rentangL13;
            end
            jumlahsementara0=zeros(1,nL13);
            jumlahsementara45=zeros(1,nL13);
            jumlahsementara90=zeros(1,nL13);
            jumlahsementara135=zeros(1,nL13);
        
            jumlahsementara0(rentangL13*(j-1)+1:akhirrentangL13)=members(L13(rentangL13*(j-1)+1:akhirrentangL13),L80(rentangL80*(i-1)+1:akhirrentangL80));
            jumlahsementara45(rentangL13*(j-1)+1:akhirrentangL13)=members(L13(rentangL13*(j-1)+1:akhirrentangL13),L845(rentangL845*(i-1)+1:akhirrentangL845));
            jumlahsementara90(rentangL13*(j-1)+1:akhirrentangL13)=members(L13(rentangL13*(j-1)+1:akhirrentangL13),L890(rentangL890*(i-1)+1:akhirrentangL890)); 
            jumlahsementara135(rentangL13*(j-1)+1:akhirrentangL13)=members(L13(rentangL13*(j-1)+1:akhirrentangL13),L8135(rentangL8135*(i-1)+1:akhirrentangL8135));  
         
            nb0(rentangL13*(j-1)+1:akhirrentangL13)=nb0(rentangL13*(j-1)+1:akhirrentangL13)+jumlahsementara0(rentangL13*(j-1)+1:akhirrentangL13);
            nb45(rentangL13*(j-1)+1:akhirrentangL13)=nb45(rentangL13*(j-1)+1:akhirrentangL13)+jumlahsementara45(rentangL13*(j-1)+1:akhirrentangL13);
            nb90(rentangL13*(j-1)+1:akhirrentangL13)=nb90(rentangL13*(j-1)+1:akhirrentangL13)+jumlahsementara90(rentangL13*(j-1)+1:akhirrentangL13);
            nb135(rentangL13*(j-1)+1:akhirrentangL13)=nb135(rentangL13*(j-1)+1:akhirrentangL13)+jumlahsementara135(rentangL13*(j-1)+1:akhirrentangL13);
        end
    end

    GLCM0=matrix(nb0,p,p)';
    GLCM45=matrix(nb45,p,p)';
    GLCM90=matrix(nb90,p,p)';
    GLCM135=matrix(nb135,p,p)';

    //------------AKHIR PEMBENTUKAN MATRIKS GLCM------------------------------ 
endfunction
