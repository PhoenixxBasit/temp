import re

# Define the grammar rules
class Parser:
    def __init__(self, expr):
        self.expr = expr
        self.tokens = self.tokenize(expr)
        self.pos = 0

    def parse(self):
        result = self.parse_expr()
        if self.pos != len(self.tokens):
            raise ValueError("Invalid syntax")
        return result

    def tokenize(self, expr):
        tokens = []
        for token in re.findall(r'\d+|\+|\-|\*|\/|\(|\)', expr):
            if token.isdigit():
                tokens.append(('number', int(token)))
            else:
                tokens.append(('operator', token))
        return tokens

    def parse_expr(self):
        result = self.parse_term()
        while self.pos < len(self.tokens) and self.tokens[self.pos][1] in ['+', '-']:
            op = self.tokens[self.pos][1]
            self.pos += 1
            right = self.parse_term()
            if op == '+':
                result += right
            else:
                result -= right
        return result

    def parse_term(self):
        result = self.parse_factor()
        while self.pos < len(self.tokens) and self.tokens[self.pos][1] in ['*', '/']:
            op = self.tokens[self.pos][1]
            self.pos += 1
            right = self.parse_factor()
            if op == '*':
                result *= right
            else:
                result /= right
        return result

    def parse_factor(self):
        if self.tokens[self.pos][1] == '(':
            self.pos += 1
            result = self.parse_expr()
            if self.tokens[self.pos][1] != ')':
                raise ValueError("Invalid syntax")
            self.pos += 1
            return result
        elif self.tokens[self.pos][0] == 'number':
            result = self.tokens[self.pos][1]
            self.pos += 1
            return result
        else:
            raise ValueError("Invalid syntax")

# Evaluate the parsed expression
def evaluate(expr):
    parser = Parser(expr)
    return parser.parse()


if __name__ == "__main__":
    expr = "3+5*(2-4/3)"
    result = evaluate(expr)
    print(result)