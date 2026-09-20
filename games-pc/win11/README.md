# Setup do Windows 11 (games/dev)

## Como funciona

O `autounattend.xml` instala o Windows 11 sem interação e, no primeiro login:

- procura em todos os drives (ISO/pendrive) o `01-install.ps1` e copia os scripts e os `.json` para `C:\Setup`;
- garante que o `winget` está instalado e funcionando (`C:\Windows\Setup\Scripts\InstallWinget.ps1`);
- cria 3 atalhos na área de trabalho, configurados para **executar como administrador**;
- tenta posicionar esses atalhos no canto superior direito da área de trabalho;
- abre o instalador do Ninite, se o `Ninite*Installer.exe` estiver na raiz de algum drive (por exemplo, a ISO/pendrive).

## Ordem de execução

Depois que o Windows terminar de instalar, use os atalhos da área de trabalho, na ordem:

1. **1 - Install apps** (`01-install.ps1`): apps gerais do `winget-apps.json` (Brave, Discord, 1Password, WhatsApp, Notion, VLC, Spotify, cliente da Steam, Epic, Riot Games, etc.). Também cria atalhos na área de trabalho para o que foi instalado.
2. **2 - Steam games** (`02-install.ps1`): abre a tela de instalação dos jogos da Steam (PUBG, Battlefield 6, CS2, Rust). **Abra a Steam e faça login antes**, e você precisa ser dono dos jogos. O script avisa se a Steam não estiver aberta.
3. **3 - Dev tools** (`03-install.ps1`): instala o WSL e depois o `winget-dev.json` (Node, Docker Desktop, GitHub Desktop, PhpStorm, Cursor, Windows Terminal). **Reinicie o PC no final**, pois o WSL e o Docker Desktop precisam disso.

Nota sobre a NVIDIA: o winget não fornece o driver de vídeo atual de forma confiável. Instale ou atualize pelo NVIDIA App ou pelo pacote de drivers da NVIDIA.

## Rodando manualmente

Se os atalhos não aparecerem, abra o PowerShell **como administrador** e execute:

```powershell
cd C:\Setup
.\01-install.ps1
.\02-install.ps1
.\03-install.ps1
```

Os scripts podem ser rodados de novo com segurança: o que já está instalado é ignorado.

## Arquivos

| Arquivo | Função |
|---|---|
| `autounattend.xml` | Instalação automática do Windows (contém só os scripts de suporte: winget, cópia dos arquivos, atalhos) |
| `01-install.ps1` | Passo 1: apps gerais |
| `02-install.ps1` | Passo 2: jogos da Steam |
| `03-install.ps1` | Passo 3: WSL e ferramentas de desenvolvimento |
| `common.ps1` | Funções compartilhadas (checagem do winget, importação, atalhos na área de trabalho). Precisa ficar na mesma pasta dos scripts |
| `winget-apps.json` | Lista de apps do passo 1 |
| `winget-dev.json` | Lista de apps do passo 3 |

## Usando na ISO

### O que colocar na raiz da ISO com o AnyBurn

Adicione estes arquivos na **raiz** (não dentro de pastas) da ISO do Windows 11:

| Arquivo | Obrigatório |
|---|---|
| `autounattend.xml` | Sim |
| `01-install.ps1` | Sim (o `CopySetupFiles.ps1` usa este arquivo para localizar o drive) |
| `02-install.ps1` | Sim |
| `03-install.ps1` | Sim |
| `common.ps1` | Sim |
| `winget-apps.json` | Sim |
| `winget-dev.json` | Sim |
| `Ninite*Installer.exe` | Opcional (por exemplo, `Ninite Brave Installer.exe`) |

Passos no AnyBurn:

1. Abra o AnyBurn e escolha **Edit image file**.
2. Selecione a ISO original do Windows 11 e clique em **Next**.
3. Clique em **Add** e selecione todos os arquivos da tabela acima.
4. Confira que eles aparecem na raiz da imagem e clique em **Next**.
5. Escolha o nome do novo arquivo `.iso` e clique em **Create Now**.

Use a ISO nova para instalar (ou grave-a em um pendrive).

No primeiro login, o `CopySetupFiles.ps1` procura o `01-install.ps1` na raiz de cada drive e copia tudo para `C:\Setup`. Se a ISO/pendrive não estiver mais conectada nesse momento, nada é copiado e aparece um aviso no `FirstLogon.log`.

O PC precisa estar **conectado por cabo (Ethernet)** no primeiro login, pois o Wi-Fi está configurado para ser ignorado na instalação e o winget precisa baixar os pacotes.

Para atualizar um script, basta editar o arquivo na raiz da ISO. Não é preciso mexer no `autounattend.xml`.

## Problemas conhecidos

- **Posição dos atalhos:** o posicionamento no canto superior direito é feito no melhor esforço (script `PlaceDesktopIcons.ps1`). Se falhar, os atalhos continuam na área de trabalho, só em outra posição.
- **Winget indisponível:** rode `C:\Windows\Setup\Scripts\InstallWinget.ps1`. O log do primeiro login fica em `C:\Windows\Setup\Scripts\FirstLogon.log`.
- **Atalhos dos apps:** só aparecem para apps instalados durante aquela execução. Apps que já estavam instalados não ganham atalho.
