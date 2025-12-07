// admin-novo.js - VERSÃO CORRIGIDA COM HOME PERFEITO

// Função para ativar uma seção
function showSection(id) {
  // Remove active de todos
  document.querySelectorAll('.section').forEach(sec => sec.classList.remove('active'));
  document.querySelectorAll('.sidebar-nav a').forEach(l => l.classList.remove('active'));
  
  // Ativa a seção desejada
  document.querySelector(id).classList.add('active');

  fetch('/admin')
      .then(response => response.json())
      .then(data => {
          console.log(data);
          popularSpans(data);
      })
      .catch(error => {
          console.error("Erro ao buscar dados:", error);
      });
  
  // Marca o link da sidebar (se não for home)
  if (id !== '#perfil') {
    const link = document.querySelector(`.sidebar-nav a[href="${id}"]`);
    if (link) link.classList.add('active');
  }
}

function popularSpans(data) {
    if (data && typeof data === 'object') {
        const nomeInput = document.querySelector('#campo-nome');
        if (nomeInput) {
            nomeInput.textContent = data.nome;
        }
        const emailSpan = document.querySelector('#campo-email')
        if(emailSpan) {
           emailSpan.textContent = data.email;
        }
        const telefone = document.querySelector('#campo-telefone')
        if(telefone) {
            telefone.textContent = data.telefone;
        }

    }
}
// === CLIQUE NOS LINKS DA SIDEBAR ===
document.querySelectorAll('.sidebar-nav a').forEach(link => {
  link.addEventListener('click', function(e) {
    e.preventDefault();
    const target = this.getAttribute('href');
    showSection(target);
    history.pushState(null, null, target);
  });
});

// === CLIQUE NO LOGO OU TÍTULO "Administração" ===
document.querySelectorAll('.home-link').forEach(link => {
  link.addEventListener('click', function(e) {
    e.preventDefault();
    showSection('#perfil');
    history.pushState(null, null, '#perfil');
  });
});

// === BOTÃO "INÍCIO" NO TOPO ===
document.getElementById('top-home-btn').addEventListener('click', () => {
  showSection('#perfil');
  history.pushState(null, null, '#perfil');
});

// === AO CARREGAR A PÁGINA ===
window.addEventListener('load', () => {
  const hash = window.location.hash || '#perfil';
  showSection(hash);
  
  // Se não tiver hash, força #perfil
  if (!window.location.hash) {
    history.replaceState(null, null, '#perfil');
  }
});

// === SUPORTE AO BOTÃO VOLTAR DO NAVEGADOR ===
window.addEventListener('popstate', () => {
  const hash = window.location.hash || '#perfil';
  showSection(hash);
});
// ===== GRÁFICO 1: PRATOS MAIS POPULARES (barras verticais) =====
const ctxPratos = document.getElementById('chartPratos');
if (ctxPratos) {
  new Chart(ctxPratos, {
    type: 'bar',
    data: {
      labels: ['Feijoada', 'Lasanha', 'Picanha', 'Salmão', 'Moqueca', 'Parmegiana'],
      datasets: [{
        label: 'Unidades vendidas',
        data: [342, 298, 276, 189, 165, 142],
        backgroundColor: '#680505',
        borderRadius: 12,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { display: false },
        title: { display: false }
      },
      scales: {
        y: { 
          beginAtZero: true,
          grid: { display: false }
        },
        x: { 
          grid: { display: false }
        }
      }
    }
  });
}

// ===== GRÁFICO 2: FATURAMENTO SEMANAL (barras horizontais) =====
const ctxFat = document.getElementById('chartFaturamentoSemanal');
if (ctxFat) {
  new Chart(ctxFat, {
    type: 'bar',
    data: {
      labels: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
      datasets: [{
        label: 'Faturamento',
        data: [8900, 11200, 9800, 12400, 15800, 21200, 18900],
        backgroundColor: '#680505',
        borderRadius: 12,
        borderSkipped: false,
      }]
    },
    options: {
      indexAxis: 'y', // <<<< BARRAS HORIZONTAIS
      responsive: true,
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function(context) {
              return `R$ ${context.parsed.x.toLocaleString('pt-BR')}`;
            }
          }
        }
      },
      scales: {
        x: { 
          beginAtZero: true,
          ticks: {
            callback: function(value) {
              return 'R$ ' + value.toLocaleString('pt-BR');
            }
          },
          grid: { display: false }
        },
        y: { 
          grid: { display: false }
        }
      },
      animation: {
        duration: 1800,
        easing: 'easeOutBounce'
      }
    }
  });
}

// GRÁFICO DE LINHAS - VENDAS ÚLTIMOS 30 DIAS
const ctxLinha = document.getElementById('linhaVendas');
if (ctxLinha) {
  new Chart(ctxLinha, {
    type: 'line',
    data: {
      labels: ['03/11', '05/11', '07/11', '09/11', '11/11', '13/11', '15/11', '17/11', '19/11', '21/11', '23/11', '25/11', '27/11', '29/11', '01/12'],
      datasets: [{
        label: 'Faturamento Diário',
        data: [8900, 9800, 10300, 11200, 11800, 12450, 13200, 12800, 13500, 14200, 13800, 15100, 14700, 15800, 16200],
        borderColor: '#680505',
        backgroundColor: 'rgba(104, 5, 5, 0.1)',
        borderWidth: 5,
        pointBackgroundColor: '#680505',
        pointRadius: 8,
        pointHoverRadius: 12,
        tension: 0.4,
        fill: true,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: '#680505',
          titleColor: 'white',
          bodyColor: 'white',
          cornerRadius: 12,
          displayColors: false,
          callbacks: {
            label: function(context) {
              return ` R$ ${context.parsed.y.toLocaleString('pt-BR')}`;
            }
          }
        }
      },
      scales: {
        x: {
          grid: { display: false },
          ticks: { color: '#666', font: { size: 12 } }
        },
        y: {
          grid: { color: 'rgba(0,0,0,0.05)' },
          ticks: {
            color: '#666',
            callback: function(value) {
              return 'R$ ' + value.toLocaleString('pt-BR');
            }
          }
        }
      },
      animation: {
        duration: 2000,
        easing: 'easeOutQuart'
      }
    }
  });
}
// ===== GESTÃO DE RESERVAS =====
let reservas = [];

// Carrega reservas do banco
async function carregarReservas() {
  const res = await fetch('/api/reservas.php');
  reservas = await res.json();
  atualizarLista();
  atualizarRelatorio();
  desenharGrafico();
}

// Atualiza lista
function atualizarLista() {
  const container = document.getElementById('listaReservas');
  const busca = document.getElementById('buscaReserva').value.toLowerCase();

  const filtradas = reservas.filter(r =>
    r.cliente.toLowerCase().includes(busca) ||
    r.mesa.includes(busca)
  );

  container.innerHTML = filtradas.map(r => `
    <div class="reserva-card">
      <div class="reserva-info">
        <h4>Mesa ${r.mesa} • ${r.data} • ${r.hora}</h4>
        <p><strong>${r.cliente}</strong> • ${r.telefone}</p>
        ${r.obs ? `<p><em>${r.obs}</em></p>` : ''}
      </div>
      <div class="reserva-actions">
        <button class="btn-small btn-edit" onclick="editarReserva(${r.id})">Editar</button>
        <button class="btn-small btn-delete" onclick="excluirReserva(${r.id})">Excluir</button>
      </div>
    </div>
  `).join('');
}

// Abre modal
function abrirModalNovaReserva() {
  document.getElementById('modalReserva').style.display = 'block';
  carregarMesasLivres();
}

// Fecha modal
function fecharModal() {
  document.getElementById('modalReserva').style.display = 'none';
  document.getElementById('formReserva').reset();
}

// Chama ao entrar na página
if (window.location.href.includes('reservas')) {
  carregarReservas();
  setInterval(carregarReservas, 30000); // atualiza a cada 30s
}