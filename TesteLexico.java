import java.io.FileReader;
import java_cup.runtime.Symbol;

public class TesteLexico {
    public static void main(String[] args) throws Exception {
        AnalisadorLexico scanner = new AnalisadorLexico(new FileReader("teste.txt"));
        Symbol token;

        while ((token = scanner.next_token()).sym != sym.EOF) {
            System.out.printf("Token: %-15s | Valor: %-10s | Linha: %d | Coluna: %d\n",
                sym.terminalNames[token.sym],
                token.value,
                token.left,
                token.right
            );
        }
    }
}

    

