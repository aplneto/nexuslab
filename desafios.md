# Resolução

A metodologia aqui descrita é uma dentre diversas possíveis formas de solucionar
os desafios do CTF. Essa resolução em particular visa se assemelhar a uma
metodologia voltada para pentests de aplicação web.

A NexusLab foi construída para simular uma aplicação vulnerável real. Algumas
das vulnerabilidades nela presentes foram propsitalmente colocadas para serem
exploradas em desafios, no entanto, existem outras falhas de segurança
(algumas propositais e outras acidentais) que a afetam. Em anexo neste arquivo
há uma relação de vulnerabilidades identificadas na aplicação, se quiser um
desafio adicional, tente encontrar as vulnerabilidades listadas.

## Whats on your head?
**Descrição**: Parte importante de um pentest web é identificar o tipo de
tecnologia com a qual se está trabalhando.

**Dicas**:
    - Verifique os headers do servidor

Os cabeçalhos de aplicações web são ótima fonte de informação sobre as
aplicações. Neste caso, para acessar os cabeçalhos da aplicação, basta examinar
as requisições no Burp Suit. Como mostra a imagem a baixo, a flag pode ser
encontrada no cabeçalho HTTP X-Flag:

![](/evidences/Whats_on_your_head.png)

## No Google, don't do it!
**Descrição**: É importante também avaliar se os desenvolvedores expuseram,
mesmo que acidentalmente, paths e funcionalidades sensíveis da aplicação.

**Dicas**:
    - Verifique o arquivo robots.txt

Outra fonte de informação é o arquivo **robots.txt**. Esse arquivo está presente
em muitas aplicações web e serve de diretriz para web crawlers indexadores, como
o Googlebot e o Bingbot, usados pelos mecanismos de busca para coletar indexar
conteúdo de sites.

Os desenvolvolvedores podem orientar esses crawlers a evitar a indexação de
determiandas partes da apliação usando a diretriz _Disallow_. Por esse motivo,
esse arquivo pode revelar recursos e funcionalidades sensíveis de uma aplicação
web.

A imagem abaixo evidencia o conteúdo do arquivo robots.txt da NexusLab:

![](/evidences/No_Google_dont_do_it_1.png)

Por sua vez, a próxima imagem evidencia o conteúdo do arquivo flag.txt:

![](/evidences/No_Google_dont_do_it_2.png)

## Hi! I'm new here.
**Descrição**: Uma vez que a tecnologia tenha sido identificada, você pode
verificar paths, diretórios e funcionalidades comumente associadas a ela.

**Dicas**:
    - Tente criar uma conta de usuário na aplicação
    - O Thin server é comumente utilizado no deploy de aplicações
    desenvolvidas com Sinatra e Rails.
    - Você pode tentar acessar a aplicação aproveitando-se de usuários com
    senhas potencialmente fracas.

A flag do [primeiro desafio](#whats-on-your-head) chamou a atenção do usuário
para os cabeçalhos HTTP da aplicação. Dentre eles, o cabeçalho **Server** indica
o uso de uma tecnologia chamada [**Thin**](https://github.com/macournoyer/thin),
que é um servidor desenvolvido para frameworks Web da linguagem Ruby, como 
[Ruby on Rails](https://rubyonrails.org/) e [Sinatra](https://sinatrarb.com/).

Por sua vez, o Ruby on Rails e outras tecnologias que usam o padrão
[MVC](https://pt.wikipedia.org/wiki/MVC) adotam convenções na nomenclatura de
partes do servidor. O Rails, por exemplo, cria rotas automáticas quando o
desenvolvedor gera modelos para a aplicação, sendo uma delas a rota "/new". Essa
rota é comumente utilizada para disponibilizar um formulário HTML usado para
cadastrar novas instâncias de um modelo no banco de dados da aplicação.

Tendo isso em mente, e conhecendo algumas das rotas da aplicação, identificadas
no [segundo desafio](#no-google-dont-do-it), podemos verificar se existe alguma
sub-rota "/new" dentre elas. E, como mostra a imagem a seguir, a rota
"/user/new" disponibiliza um formulário de cadastro.

![](/evidences/Hi_Im_new_here_1.png)

Por sua vez, a próxima flag pode ser encontrada no código-fonte dessa página,
como mostra a imagem:

![](/evidences/Hi_Im_new_here_2.png)

A partir daí, basta preencher o cadastro e obter acesso a funcionalidade.

Mais detalhes sobre rotas no Ruby on Rails podem ser encontrados
[aqui](https://guides.rubyonrails.org/routing.html).

## Who's the boss

**Descrição**: É importante identificar os usuários da aplicação e os atributos
que compõem seus cadastros.

**Dicas**:
    - Identifique o perfil do administrador da plataforma.
    - Observe o código-fonte da página de perfil do administrador.

Depois de conseguir criar uma conta e fazer login. Ao clicar no botão
"Perfil", na barra de navegação, o usuário é redirecionado para a URL
"/user/:id", onde `:id` é o id do perfil do usuário. Ao modificar o valor desse
parâmetro é possível visualizar os perfis de outros usuários da aplicação.
O usuário administrador tem o perfil de id 1, como mostra a imagem:

![](/evidences/Whos_the_boss_1.png)

Como mostra a próxima imagem, a flag pode ser encontrada no
código-fonte da página.

![](/evidences/Whos_the_boss_2.png)

### Notas
1. A rota "/modelo/:id" é outra das rotas comumente criadas pelo Ruby on
Rails. Uma vez que é possível a visualização dos usuários da aplicação sem a
necessidade de realizar o login, é possível a obtenção dessa flag antes da
resolução do [desafio anterior](#hi-im-new-here).

2. Uma outra forma de conseguir acesso a aplicação é através de um ataque
contra o mecanismo de autenticação. Uma vez que o endereço de e-mail dos
usuários está listado em seu perfil, é possível a usar _wordlists_ de senhas,
conhecidas como a [RockYou.txt](https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz)
para fazer login como um dos usuários cadastrados.

## Confidencial report!

**Descrição**: Agora é hora de coletar as evidenciais. Tente identificar o
funcionário da Wicked Corp suspeito das acusações e colete as evidências
necessárias.

**Dicas**:
    - Acesse os projetos dos usuários da aplicação.
    - Metadados comumente possuem informações potencialmente sensíveis. Use uma
    ferramenta como o [Exiftool](https://exiftool.org/), ou uma extensão do
    BurpSuite para verificar os metadados de arquivos recuperados da aplicação.

Uma vez que o login na aplicação tenha sido feito, é possível acessar os
projetos listados nos perfis dos usuários da aplicação. Ao acessar um projeto o
usuário logado é redirecionado para a url "/project/:id", onde o parâmetro `:id`
representa o id do projeto.

O projeto em questão é o de Id 6, intitulado "Boiuna". Nele há o arquivo
**Report.pdf**. Como mostram as próximas imagens, a flag pode ser encontrada
tanto oculta no conteúdo do arquivo (texto com fonte branca num fundo branco),
quanto em seus metadados.

![](/evidences/Confidential_report_1.png)

![](/evidences/Confidential_report_2.png)

## Up we go!

**Descrição**: Uma falha muito comum em aplicações é a má gestão de acesso, o
que pode permitir escalações horizontais e verticais de privilégios.

**Dicas**:
    - Tente acessar o painel administrativo da aplicação
    - Um dos principais componentes do protocolo HTTP é o método.
    A [RFC-7231](https://datatracker.ietf.org/doc/html/rfc7231#section-4.3)
    define funções específicas para cada um dos métodos.
    Atente-se aos atributos que compõem um usuário e combine essa informação com o
    seu conhecimento sobre métodos HTTP.

A RFC-7231, que define o método HTTP, atribui funcionalidades específicas para
cada um dos métodos do protocolo. O método GET, por exemplo, está associado a
consulta e recuperação de recursos da aplicação. Por sua vez, o método POST,
comumente usado em formulários HTML, é, em teoria, usado em requisições que
envolvem o processamento de dados fornecidos pelo cliente da aplicação. Um
exemplo são as funcionalidades de login e cadastro, que criam uma nova sessão e
um novo registro de usuário, respectivamente. Por sua vez, o método PUT está
associado a modificação de dados.

Além disso, ao examinar o código-fonte da página de perfil do usuário
administrador, identificado no [terceiro desafio](#whos-the-boss), é possível
constatar a presença de um comentário HTML que desabilita um campo do
formulário:

```html
<!--
<div class="field">
    <spam>TAC{26b0a3d0a2f49b630a75dba50d640eab51aff655f05dbe5c07cc3b886ba26eed}</spam>
    <label for="is_admin" class="label">Administrador</label>
    <div class="control">
        <input type="checkbox" name="is_admin" id="is_admin">
    </div>
</div>
-->
```

A presença desse input no pefil do Administrador e não nos outros perfis indica
a existência de um atributo booleano no pefil dos usuários. Com isso em mente,
existe mais de um abordagem para conseguir acesso administrador na aplicação.

1. O primeiro método é enviando uma requisição PUT para modificar o cadastro do
usuário administrador. Para isso, envie uma requisição com o parâmetro a ser
modificado, nesse caso o parâmetro **password** e o novo valor desse parâmetro.

![](/evidences/Up_we_go_1.png)

A rota "PUT /user/:id" é também uma convenção do Ruby on Rails, que usa o método
PUT para modificação de modelos existentes.

2. O segundo método é através do formulário de registro. Uma vez que foi
possível identificar a existência de um atributo aparentemente booleano na
tabela que representa os usuários da aplicação, é possível cadastrar um usuário
administrar a partir da inserção do parâmetro **is_admin** com o valor **true**
na requisição de registro:

![](/evidences/Up_we_go_2.png)

Ambos os casos resultam na obtenção de acesso com nível de administrador na
aplicação. Depois de efetuar login, é possível encontrar a flag desse desafio na
URL "/admin", como mostra a imagem:

![](/evidences/Up_we_go_3.png)

Nota: existe pelo menos mais uma forma de realizar esse acesso. Você consegue
descobrir qual é?

## A taste of your own medicine...

**Descrição**: Hora de a Wicked S.A. provar do próprio veneno!

**Dicas**:
    - Execute o ransomware da Wicked S.A no servidor deles.
    - Lembre-se, tags HTML não são usadas apenas para escrever páginas
    estáticas.

Além do relatório que conta como a Wicked S.A. usou o ransomware Boiuna contra
um de seus ex-clientes, o outro arquivo disponível durante a resolução do desaio
[_Confidencial report!_](#confidencial-report), é o _Changelog_ do ransomware.
No final desse arquivo o desenvolvedor menciona que o ransomware foi removido do
repositório do projeto, mas que pode ser baixado via SSH do servidor. Embora o
acesso a SSH não seja possível, ainda existem formas alternativas de executar
comandos nesse servidor.

Uma das principais vulnerabilidades que afeta servidores escritos em Ruby é a de
Server-Side Template Injection. Essa vulnerabilidade permite que o cliente
forneça código para que o servidor execute. Esses templates são comumente
compostos por código HTML e código Ruby em tags especiais, dependendo da
linguagem de tamplate utilizada. Mais detalhes podem ser encontrados
[aqui](https://portswigger.net/web-security/server-side-template-injection).

Para identificar pontos da aplicação onde a vulnerabilidade pode ser explorada é
importante detectar funcionalidades que processem e reflitam dados fornecdos
pelo cliente. Esses pontos podem se assemelhar a pontos vulneráveis a
vulnerabilidades de
[XSS](https://www.sidechannel.blog/cross-site-scripting-xss-variantes-e-correcao/).
Diversos pontos da NexusLab possuem essa característica, como os perfis de
usuário, mas apenas a funcionalidade de avisos está vulnerável.

Um teste simples para confirmar a linguagem de templates usada pelo servidor é o
envio de _payloads_ contento sintáxes de diferentes templates. O envio do
_payload_ a seguir confirma que a linguagem de template usada pelo servidor é a
[Embedded Ruby](https://www.puppet.com/docs/puppet/5.5/lang_template_erb.html).

```erb
<%= 2*2 %>
```

As imagens a seguir mostram, respectivamente, o envio do payload e a execução do
template no servidor:

![](/evidences/A_taste_of_your_own_medicine_1.png)

![](/evidences/A_taste_of_your_own_medicine_2.png)

A partir dessa vulnerabilidade, é possível executar comandos no sistema
operacional do servidor. O payload a seguir permite transformar um aviso em uma
web shell que recebe e executa comandos recebidos através de um parâmetro da
URL, nesse caso o parâmetro **cmd**:

```html
<%= `#{params[:cmd]}` %>
```

Para melhor visualização, o payload a seguir foi utilizado ao invés do anterior:

```html
<form action="/avisos/7" method="get">
    <textarea id="" cols="30" rows="10">
    <% if params.key? "cmd"%>
    <%= `#{params["cmd"]}`%>
    <% end %>
    </textarea>
    <input type="text" name="cmd" id="">
    <input type="submit" value="executar">
</form>
```

Quando interpretado pelo servidor, o template anterior resulta na seguinte
página:

![](/evidences/A_taste_of_your_own_medicine_4.png)

Por fim, a execução de comandos acontece através do envio de comandos usando o
parâmetro GET **cmd**, que pode ser enviado diretamente na URL ou, no caso desse
payload, através do formulário.

A imagem a seguir evidencia a execução do comando "ls" no sistema operacional:

![](/evidences/A_taste_of_your_own_medicine_5.png)

Uma vez que seja possível executar comandos no sistema operacional da aplicação,
é preciso encontrar o ransomware da Wicked S.A para obter a última flag. A busca
pode ser feita tanto de forma manual, mas o comando abaixo pode automatizá-la:

```bash
find / -iname boiuna -type f 2>/dev/null
```

A execução desse comando resulta no output da imagem abaixo:

![](/evidences/A_taste_of_your_own_medicine_6.png)

Por fim, a execução desse arquivo resulta no seguinte output:

![](/evidences/A_taste_of_your_own_medicine_7.png)

## Anexo

A seguir está uma lista com algumas das vulnerabilidades identificadas na
aplicação durante o seu desenvolvimento e durante o CTF. Algumas delas foram
descritas nesta resolução e outras não. Tente identificar essas vulnerabilidades
e, caso se sinta confortável, outras falhas que podem ter surgido no processo de
desenvolvimento. Caso queira feedback, fique a vontade para criar uma issue
sugerindo uma solução para uma vulnerabilidade identificada ou apontando uma
nova vulnerabilidade. Vamos respondê-los assim que possível.

* [Sensitive information leakage](https://cwe.mitre.org/data/definitions/200.html)
* [Cross-site scripting](https://cwe.mitre.org/data/definitions/79.html)
* [Server-Side Template Injection](https://cwe.mitre.org/data/definitions/1336.html)
* [Mass assignment](https://cwe.mitre.org/data/definitions/915.html)
* [Improper Authorization](https://cwe.mitre.org/data/definitions/285.html)
* [Insecure Direct Object Reference](https://cwe.mitre.org/data/definitions/639.html)
* [Improper Restriction of Excessive Authentication Attempts](https://cwe.mitre.org/data/definitions/307.html)
* [User enumeration](https://cwe.mitre.org/data/definitions/204.html)

## Referências

* https://www.sidechannel.blog/cross-site-scripting-xss-variantes-e-correcao/
* https://portswigger.net/web-security/server-side-template-injection
* https://www.sidechannel.blog/falhas-no-controle-de-acesso-em-aplicacoes-web/
* https://www.sidechannel.blog/era-uma-vez-uma-enumeracao-de-usuarios/
* https://www.sidechannel.blog/ataques-de-forca-bruta-medidas-de-protecao-e-mitigacao/
* 