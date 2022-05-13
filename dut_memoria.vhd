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

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity dut_memoria is
	port(
		--Relogio
	    	clock        : in std_logic;

		-------Variaveis para memoria A (canal unico)------

		--Enable: indica a memoria a ser usada esta desabilitada
		enable_A      : in std_logic;
		--Indica se eh escrita '1' ou leitura '0'
		read_write   : in std_logic;
		--endereco da memoria a ser acessada
		address      : in std_logic_vector(4 downto 0);
		--Conteudo da memoria a ser escrito e lido
		data         : inout std_logic_vector(3 downto 0);

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
		data_in_B      : in std_logic_vector(3 downto 0);
		--Conteudo da memoria a ser lido
		data_out_B     : out std_logic_vector(3 downto 0);

		-------Variaveis para memoria C (Acesso duplo)------

		--Enable: indica se a memoria a ser usada esta desabilitada
		enable_C       : in std_logic;

		--Condicao de leitura_1 (000), escrita_1 (001), leitura_1 e escrita_1 (010)
		--Condicao de leitura_2 (011), escrita_2 (100), leitura_2 e escrita_2 (101)
		--Condicao de leitura_2 e leitura_1 (110), leitura_1 leitura_2 e escrita_1 escrita_2 (111)
		condition_C     : in std_logic_vector(2 downto 0);

		--------          Usuario 1       -------------
		--endereco da memoria a ser acessada para leitura
		read_address_1C : in std_logic_vector(4 downto 0);
		--endereco da memoria a ser acessada para escrita
		write_address_1C: in std_logic_vector(4 downto 0);
		--Conteudo da memoria a ser escrito
		data_in_1C      : in std_logic_vector(3 downto 0);
		--Conteudo da memoria a ser lido
		data_out_1C     : out std_logic_vector(3 downto 0);

		--------          Usuario 2       -------------

		--endereco da memoria a ser acessada para leitura
		read_address_2C : in std_logic_vector(4 downto 0);
		--endereco da memoria a ser acessada para escrita
		write_address_2C: in std_logic_vector(4 downto 0);
		--Conteudo da memoria a ser escrito
		data_in_2C      : in std_logic_vector(3 downto 0);
		--Conteudo da memoria a ser lido
		data_out_2C     : out std_logic_vector(3 downto 0)
		
    );
end dut_memoria;

architecture basic of dut_memoria is
	
	--Tipo de acesso a memoria selecionado
   	signal tipodeacesso : std_logic_vector(2 downto 0);

	--Memoria do projeto
	--Profundidade de 32, ou seja, 5 bits
	--Cada espaco armazena um std_logic_vector de 4 bits
	type mem_ty is array (0 to 31) of std_logic_vector (3 downto 0);
	signal mem : mem_ty;

    	signal data_out : std_logic_vector (3 downto 0);
	begin
	
	tipodeacesso <= enable_A & enable_B & enable_C;	
	process (clock)
		begin
		if (rising_edge(clock)) then
			case tipodeacesso is
				when "100" =>
					case read_write is
						when '1' =>
							mem(to_integer(unsigned(address))) <= data;
						when '0' =>
							data_out <= mem(to_integer(unsigned(address)));
						when others =>
					end case;
					
				when "010" =>
					case condition_B is
						--Leitura
						when "00" =>
							data_out_B <= mem(to_integer(unsigned(read_address_B)));
						--Escrita
						when "01" =>
							mem(to_integer(unsigned(write_address_B))) <= data_in_B;
						--Escrita e leitura
						when "10" =>
							data_out_B <= mem(to_integer(unsigned(read_address_B)));
							mem(to_integer(unsigned(write_address_B))) <= data_in_B;
						when others =>
					end case;
				when "001" =>
					case condition_C is
						--Leitura usuario 1
						when "000" =>
							data_out_1C <= mem(to_integer(unsigned(read_address_1C)));
						--Escrita usuario 1
						when "001" =>
							mem(to_integer(unsigned(write_address_1C))) <= data_in_1C;
						--Leitura e escrita usuario 1
						when "010" =>
							data_out_1C <= mem(to_integer(unsigned(read_address_1C)));
							mem(to_integer(unsigned(write_address_1C))) <= data_in_1C;
						--Leitura usuario 2
						when "011" =>
							data_out_2C <= mem(to_integer(unsigned(read_address_2C)));
						--Escrita usuario 2
						when "100" =>
							mem(to_integer(unsigned(write_address_2C))) <= data_in_2C;
						--Leitura e Escrita usuario 2
						when "101" =>
							data_out_2C <= mem(to_integer(unsigned(read_address_2C)));
							mem(to_integer(unsigned(write_address_2C))) <= data_in_2C;
						--Leitura usuario 1 e 2
						when "110" =>
							data_out_1C <= mem(to_integer(unsigned(read_address_1C)));
							data_out_2C <= mem(to_integer(unsigned(read_address_2C)));
						--Leitura e Escrita usuario 1 e 2
						when "111" =>
							data_out_2C <= mem(to_integer(unsigned(read_address_2C)));
							mem(to_integer(unsigned(write_address_2C))) <= data_in_2C;
							data_out_1C <= mem(to_integer(unsigned(read_address_1C)));
							mem(to_integer(unsigned(write_address_1C))) <= data_in_1C;
						when others =>
					end case;
				when others =>
			end case;
		end if;
	end process;
	
	data <= data_out when (read_write = '0') else (others=>'Z');
	
		

end basic;