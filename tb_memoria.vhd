-- Aluno: Lucas Henrique Alves Rosa
-- Matricula: 180042572
-- Trabalho 6
-- Simulacao de acesso a memorias
-- 
-- 3 Acessos a memória: A- acesso canal unico; B- acesso canal duplo; C- acesso duplo
-- enable's indicam qual tipo de acesso esta habilitado para uso
-- read_write indica qual operacao deve ser executada no acesso A (2 operacoes)
-- condition_B indica qual operacao deve ser executada no acesso B (3 operacoes)
-- condition_C indica qual operacao deve ser executada no acesso C (8 operacoes)
--
--Memoria do projeto:
--Profundidade de 32, ou seja, 5 bits
--Cada espaco armazena um std_logic_vector de 4 bits

--Na simulação recomendo colocar conjuntos de acesso de maneira agrupada para melhor visualizacao


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_memoria is
	
end entity;

architecture sim of tb_memoria is
	component dut_memoria is
		port(
			--Relogio
	    		clock         : in std_logic;

			-------Variaveis para memoria A (canal unico)------

			--Enable: indica a memoria a ser usada esta desabilitada
			enable_A       : in std_logic;
			--Indica se eh escrita '1' ou leitura '0'
			read_write    : in std_logic;
			--endereco da memoria a ser acessada
			address       : in std_logic_vector(4 downto 0);
			--Conteudo da memoria a ser escrito e lido
			data          : inout std_logic_vector(3 downto 0);

			-------Variaveis para memoria B (canal duplo)------

			--Enable: indica se a memoria a ser usada esta desabilitada
			enable_B       : in std_logic;
			--Condicao de leitura (00) escrita (01) ou leitura e escrita (10)
			condition_B     : in std_logic_vector(1 downto 0);
			--endereco da memoria a ser acessada para leitura
			read_address_B : in std_logic_vector(4 downto 0);
			--endereco da memoria a ser acessada para escrita
			write_address_B: in std_logic_vector(4 downto 0);
			--Conteudo da memoria a ser escrito
			data_in_B     : in std_logic_vector(3 downto 0);
			--Conteudo da memoria a ser lido
			data_out_B     : out std_logic_vector(3 downto 0);

			-------Variaveis para memoria C (Acesso duplo)------

			--Enable: indica se a memoria a ser usada esta desabilitada
			enable_C       : in std_logic;
			--Condicao de leitura_1 (000), escrita_1 (001), leitura_1 e escrita_1 (010)
			--Condicao de leitura2 (011), escrita2 (100), leitura2 e escrita2 (101)
			--Condicao de leitura2 e leitura_1 (110), leitura_1 leitura2 e escrita_1 escrita2 (111)
			condition_C     : in std_logic_vector(2 downto 0);

			-----      Usuario 1        -----

			--endereco da memoria a ser acessada para leitura
			read_address_1C : in std_logic_vector(4 downto 0);
			--endereco da memoria a ser acessada para escrita
			write_address_1C: in std_logic_vector(4 downto 0);
			--Conteudo da memoria a ser escrito
			data_in_1C      : in std_logic_vector(3 downto 0);
			--Conteudo da memoria a ser lido
			data_out_1C     : out std_logic_vector(3 downto 0);


			-----      Usuario 2        -----

			--endereco da memoria a ser acessada para leitura
			read_address_2C : in std_logic_vector(4 downto 0);
			--endereco da memoria a ser acessada para escrita
			write_address_2C: in std_logic_vector(4 downto 0);
			--Conteudo da memoria a ser escrito
			data_in_2C      : in std_logic_vector(3 downto 0);
			--Conteudo da memoria a ser lido
			data_out_2C     : out std_logic_vector(3 downto 0)
    		);
	end component;
	

	signal clock           : std_logic;
	signal enable_A        : std_logic;
	signal read_write      : std_logic;
	signal address         : std_logic_vector(4 downto 0);
	signal data            : std_logic_vector(3 downto 0);
	signal enable_B        : std_logic;
	signal condition_B     : std_logic_vector(1 downto 0);
	signal read_address_B  : std_logic_vector(4 downto 0);
	signal write_address_B : std_logic_vector(4 downto 0);
	signal data_in_B       : std_logic_vector(3 downto 0);
	signal data_out_B      : std_logic_vector(3 downto 0);
	signal enable_C        : std_logic;
	signal condition_C     : std_logic_vector(2 downto 0);
	signal read_address_1C : std_logic_vector(4 downto 0);
	signal write_address_1C: std_logic_vector(4 downto 0);
	signal data_in_1C      : std_logic_vector(3 downto 0);
	signal data_out_1C     : std_logic_vector(3 downto 0);
	signal read_address_2C : std_logic_vector(4 downto 0);
	signal write_address_2C: std_logic_vector(4 downto 0);
	signal data_in_2C      : std_logic_vector(3 downto 0);
	signal data_out_2C     : std_logic_vector(3 downto 0);
begin
my_memoria: dut_memoria
	port map(
		clock => clock,
        	enable_A => enable_A,
        	read_write => read_write,
		address => address,
		data => data,
        	enable_B => enable_B,
		condition_B => condition_B,
        	read_address_B => read_address_B,
		write_address_B => write_address_B,
	  	data_in_B => data_in_B,
        	data_out_B => data_out_B,
        	enable_C => enable_C,
		condition_C => condition_C,
		read_address_1C => read_address_1C,
		write_address_1C => write_address_1C,
        	data_in_1C => data_in_1C,
        	data_out_1C => data_out_1C,
		read_address_2C => read_address_2C,
		write_address_2C => write_address_2C,
        	data_in_2C => data_in_2C,
        	data_out_2C => data_out_2C
	);

	
	--clock vai mover o sistema a cada 2 ns
	process is
		begin
			clock <= '0';
			wait for 1 ns;
			clock <= '1';
			wait for 1 ns;
	end process;
	
	process is
		begin	
			------  Acesso a memoria por canal unico -------
			enable_A <= '1';
			enable_B <= '0';
			enable_C <= '0';
			wait for 2 ns;
			--Escrita (Posicao 0 da memória / Dado: 15)
			read_write <= '1';
			address <= "00000";
			data <= "1111";
			wait for 2 ns;
			--Escrita (posicao 1 da memoria / Dado: 14)
			read_write <= '1';
			address <= "00001";
			data <= "1110";
			wait for 2 ns;
			--Leitura (posicao 0 da memoria)
			read_write <= '0';
			address <= "00000";
			wait for 2 ns;
			--Leitura (posicao 1 da memoria)
			read_write <= '0';
			address <= "00001";
			wait for 2 ns;

			------  Acesso a memoria por canal duplo -------
			enable_A <= '0';
			enable_B <= '1';
			enable_C <= '0';
			wait for 2 ns;
			--Escrita (Posicao 2 da memória / Dado: 1)
			condition_B <= "01";
			write_address_B <= "00010";
			data_in_B <= "0001";
			wait for 2 ns;
			--Escrita (posicao 3 da memoria / Dado: 2)
			condition_B <= "01";
			write_address_B <= "00011";
			data_in_B <= "0010";
			wait for 2 ns;
			--Leitura (posicao 2 da memoria)
			--Escrita (posicao 2 da memoria / Dado: 3)
			condition_B <= "10";
			read_address_B <= "00010";
			data_in_B <= "0011";
			write_address_B <= "00010";
			wait for 2 ns;
			--Leitura (posicao 2 da memoria)
			condition_B <= "00";
			read_address_B <= "00010";
			wait for 2 ns;
			--Leitura (posicao 3 da memoria)
			condition_B <= "00";
			read_address_B <= "00011";
			wait for 2 ns;
			


			------  Acesso a memoria por acesso duplo -------
			enable_A <= '0';
			enable_B <= '0';
			enable_C <= '1';
			wait for 2 ns;
			--Escrita Usuario 1 (Posicao 10 da memória / Dado: 5)
			condition_C <= "001";
			write_address_1C <= "01010";
			data_in_1C <= "0101";
			wait for 2 ns;
			--Leitura Usuario 1 (posicao 10 da memoria)
			condition_C <= "000";
			read_address_1C <= "01010";
			wait for 2 ns;
			--Leitura Usuario 1 (posicao 10 da memoria)
			--Escrita Usuario 1 (posicao 10 da memoria / Dado: 6)
			condition_C <= "010";
			read_address_1C <= "01010";
			write_address_1C <= "01010";
			data_in_1C <= "0110";
			wait for 2 ns;
			--Escrita Usuario 2 (Posicao 11 da memória / Dado: 7)
			condition_C <= "100";
			write_address_2C <= "01011";
			data_in_2C <= "0111";
			wait for 2 ns;
			--Leitura Usuario 2 (posicao 11 da memoria)
			condition_C <= "011";
			read_address_2C <= "01011";
			wait for 2 ns;
			--Leitura Usuario 2 (posicao 11 da memoria
			--Escrita Usuario 2 (posicao 11 da memoria / Dado: 8)
			condition_C <= "101";
			read_address_2C <= "01011";
			write_address_2C <= "01011";
			data_in_2C <= "1000";
			wait for 2 ns;
			--Leitura Usuario 1 (posicao 11 da memoria)
			--Leitura Usuario 2 (posicao 10 da memoria)
			condition_C <= "110";
			read_address_1C <= "01011";
			read_address_2C <= "01010";
			wait for 2 ns;
			--Leitura Usuario 1 (posicao 10 da memoria)
			--Escrita Usuario 1 (posicao 10 da memoria / Dado: 9)
			--Leitura Usuario 2 (posicao 11 da memoria)
			--Escrita Usuario 2 (posicao 11 da memoria / Dado: 9)
			condition_C <= "111";
			read_address_1C <= "01010";
			write_address_1C <= "01010";
			data_in_1C <= "1001";
			read_address_2C <= "01011";
			write_address_2C <= "01011";
			data_in_2C <= "1001";
			wait for 2 ns;
			--Leitura Usuario 1 (posicao 11 da memoria)
			--Leitura Usuario 2 (posicao 10 da memoria)
			condition_C <= "110";
			read_address_1C <= "01011";
			read_address_2C <= "01010";
			wait;
	end process;


end architecture;

