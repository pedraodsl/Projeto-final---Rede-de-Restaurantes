// avaliacoes.js – TOTALMENTE DINÂMICO
document.addEventListener('DOMContentLoaded', async () => {
  const modoBtn = document.getElementById('modo-btn');
  const hamburger = document.getElementById('hamburger');
  const navLinks = document.getElementById('nav-links');

  // Elementos do prato
  const pratoImg = document.getElementById('prato-img');
  const pratoNome = document.getElementById('prato-nome');
  const pratoDetalhes = document.getElementById('prato-detalhes');
  const mediaEstrelas = document.getElementById('media-estrelas');
  const mediaNota = document.getElementById('media-nota');
  const totalAvaliacoes = document.getElementById('total-avaliacoes');

  // Formulário
  const estrelas = document.querySelectorAll('#estrelas-avaliar .estrela');
  const nomeInput = document.getElementById('nome-cliente');
  const comentarioInput = document.getElementById('comentario');
  const btnEnviar = document.getElementById('enviar-avaliacao');
  const lista = document.getElementById('avaliacoes-lista');

  let avaliacaoSelecionada = 0;
  let pedidoAtual = {};

  // === CARREGAR PEDIDO ATUAL ===
  try {
    const res = await fetch('dados/pedidoAtual.json');
    if (!res.ok) throw new Error('Pedido não encontrado');
    pedidoAtual = await res.json();

    pratoImg.src = pedidoAtual.imagem;
    pratoNome.textContent = pedidoAtual.prato;
    pratoDetalhes.textContent = `Pedido realizado em ${pedidoAtual.data} • Mesa ${pedidoAtual.mesa}`;
    mediaNota.textContent = pedidoAtual.mediaNota;
    totalAvaliacoes.textContent = pedidoAtual.totalAvaliacoes;
    mediaEstrelas.textContent = '★'.repeat(Math.round(pedidoAtual.mediaNota)) + '☆'.repeat(5 - Math.round(pedidoAtual.mediaNota));
  } catch (err) {
    pratoNome.textContent = "Erro ao carregar pedido";
    console.error(err);
  }

  // === MODO ESCURO ===
  if (localStorage.getItem('darkMode') === 'true') {
    document.body.classList.add('dark-mode');
    modoBtn.checked = true;
  }
  modoBtn.addEventListener('change', () => {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', modoBtn.checked);
  });

  // ===== MENU HAMBÚRGUER =====
hamburger.addEventListener('click', () => {
  navLinks.classList.toggle('show');
  hamburger.innerHTML = navLinks.classList.contains('show') ? "&times;" : "&#9776;";
});

// Fechamento suave do menu ao clicar nos links
const links = navLinks.querySelectorAll('a');
links.forEach(link => {
  link.addEventListener('click', (e) => {
    if (navLinks.classList.contains('show')) {
      e.preventDefault();
      navLinks.classList.remove('show');
      hamburger.innerHTML = "&#9776;";
      setTimeout(() => { window.location.href = link.href; }, 500);
    }
  });
});


  // === ESTRELAS ===
  estrelas.forEach(estrela => {
    estrela.addEventListener('click', () => {
      avaliacaoSelecionada = estrela.dataset.valor;
      atualizarEstrelas();
    });
    estrela.addEventListener('mouseover', () => {
      if (!avaliacaoSelecionada) preencherTemporario(estrela.dataset.valor);
    });
  });

  document.getElementById('estrelas-avaliar').addEventListener('mouseleave', () => {
    if (!avaliacaoSelecionada) limparEstrelas();
  });

  function atualizarEstrelas() {
    estrelas.forEach(e => e.classList.toggle('preenchida', e.dataset.valor <= avaliacaoSelecionada));
  }
  function preencherTemporario(valor) {
    estrelas.forEach(e => e.classList.toggle('preenchida', e.dataset.valor <= valor));
  }
  function limparEstrelas() {
    estrelas.forEach(e => e.classList.remove('preenchida'));
  }

  // === ENVIAR AVALIAÇÃO ===
  btnEnviar.addEventListener('click', () => {
    if (avaliacaoSelecionada === 0) return alert('Selecione de 1 a 5 estrelas!');
    if (comentarioInput.value.trim().length < 10) return alert('Escreva pelo menos 10 caracteres.');

    const nova = {
      id: Date.now(),
      nome: nomeInput.value.trim() || 'Anônimo',
      estrelas: parseInt(avaliacaoSelecionada),
      comentario: comentarioInput.value.trim(),
      data: new Date().toLocaleDateString('pt-BR')
    };

    const avaliacoes = JSON.parse(localStorage.getItem('avaliacoesBellor') || '[]');
    avaliacoes.unshift(nova);
    localStorage.setItem('avaliacoesBellor', JSON.stringify(avaliacoes));

    alert('Avaliação enviada com sucesso! Obrigado!');
    limparFormulario();
    carregarAvaliacoes();
  });

  function limparFormulario() {
    avaliacaoSelecionada = 0;
    nomeInput.value = '';
    comentarioInput.value = '';
    limparEstrelas();
  }

  // === CARREGAR AVALIAÇÕES ===
  function carregarAvaliacoes() {
    const avaliacoes = JSON.parse(localStorage.getItem('avaliacoesBellor') || '[]');
    lista.innerHTML = avaliacoes.length === 0 
      ? '<p style="text-align:center; color:#999; padding:3rem;">Nenhuma avaliação ainda. Seja o primeiro!</p>'
      : '';

    avaliacoes.forEach(av => {
      const item = document.createElement('div');
      item.className = 'avaliacao-item';
      item.innerHTML = `
        <img src="https://i.pravatar.cc/150?img=${av.id % 70}" alt="Cliente" class="foto-perfil">
        <div class="avaliacao-conteudo">
          <h4>${av.nome} <span class="estrelas">${'★'.repeat(av.estrelas)}${'☆'.repeat(5-av.estrelas)}</span></h4>
          <small>${av.data}</small>
          <p>${av.comentario}</p>
        </div>
      `;
      lista.appendChild(item);
    });
  }

  carregarAvaliacoes();
});