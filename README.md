# Memory_PWM
Memórias são elementos essenciais para a maioria dos sistemas computacionais. Dependendo da complexidade
e dos requisitos dos sistemas, diversos tipos de formas de acesso à memória foram criados. Neste projeto, você
deve implementar os seguintes tipos:

A. Memória de canal único: possui um canal de dados que serve tanto de entrada quanto de saída (verifique
como implementar “inout” em VHDL). O sinal “read_write” determina se a operação a ser realizada é de
escrita ou leitura de dados.

B. Memória de canal duplo: possui canais exclusivos de escrita e de leitura. Em todo ciclo há leitura e escrita,
a menos que a memória esteja desabilitada (sinal “enable”). O contexto a ser implementado é o “readafter-write”, ou seja, primeiro lê-se o valor, depois escreve-se. O caso especial de teste é a leitura e escrita
simultâneas no mesmo endereço de memória.

C. Memória de acesso duplo: permite leituras e escritas simultâneas por dois acessos. Como forma de
visualização, imagine dois usuários podendo ler e escrever na mesma memória concomitantemente. O
contexto a ser implementado é o mesmo, “read-after-write”.

![image](https://user-images.githubusercontent.com/65405310/168209540-1be2ca28-1ed1-452d-88bf-c0287cec9551.png)
