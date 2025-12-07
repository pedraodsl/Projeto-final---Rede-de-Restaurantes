let reservas = [];

// Carregar dados
fetch('data/reservas.json')
  .then(r => r.json())
  .then(data => {
    reservas = data;
    hoje();
    desenharGrafico();
  });

// Hoje automático
function hoje() {
  const hoje = new Date().toISOString().slice(0,10);
  document.getElementById('filtroData').value = hoje;
  filtrar();
}

// Render tabela
function render() {
  const filtro = document.getElementById('filtroData').value;
  const tbody = document.getElementById('tabela-body');
  const hoje = new Date().toISOString().slice(0,10);
  const doDia = reservas.filter(r => r.data === (filtro || hoje));
  const ocupadas = doDia.length;

  tbody.innerHTML = doDia.map(r => `
    <tr>
      <td><strong>${r.cliente}</strong></td>
      <td>${r.telefone}</td>
      <td>${r.data.split('-').reverse().join('/')}</td>
      <td>${r.horario}</td>
      <td><span class="mesa-badge">Mesa ${r.mesa}</span></td>
      <td><strong>${32 - ocupadas} / 32</strong></td>
      <td>
        <button class="btn-edit">Editar</button>
        <button class="btn-delete" onclick="excluir(${r.id})">Excluir</button>
      </td>
    </tr>
  `).join('');
}

// Filtrar
function filtrar() { render(); }
function filtrarHoje() { hoje(); render(); }
function limparFiltro() {
  document.getElementById('filtroData').value = '';
  render();
}

// Excluir
function excluir(id) {
  if(confirm('Excluir reserva?')) {
    reservas = reservas.filter(r => r.id !== id);
    salvarNoJSON();
    render();
    desenharGrafico();
  }
}

// Modal
function abrirModal() {
  document.getElementById('modalReserva').style.display = 'flex';
}
function fecharModal() {
  document.getElementById('modalReserva').style.display = 'none';
}

// Criar reserva
document.getElementById('formReserva').onsubmit = function(e) {
  e.preventDefault();
  const form = e.target;
  const nova = {
    id: Date.now(),
    cliente: form[0].value,
    telefone: form[1].value,
    data: form[2].value,
    horario: form[3].value,
    mesa: form[4].value
  };
  reservas.push(nova);
  salvarNoJSON();
  fecharModal();
  form.reset();
  render();
  desenharGrafico();
};

// Salvar no JSON (simula banco)
function salvarNoJSON() {
  const data = JSON.stringify(reservas, null, 2);
  const blob = new Blob([data], {type: 'application/json'});
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'data/reservas.json';
  a.click();
}

// Gráfico 12 semanas
function desenharGrafico() {
  const ctx = document.getElementById('graficoSemanas').getContext('2d');
  const semanas = [];
  const dados = [];

  for(let i = 11; i >= 0; i--) {
    const inicio = new Date();
    inicio.setDate(inicio.getDate() - i*7 - inicio.getDay() + 1);
    const fim = new Date(inicio);
    fim.setDate(fim.getDate() + 6);
    const label = `${inicio.getDate()}/${inicio.getMonth()+1}`;
    semanas.push(label);

    const count = reservas.filter(r => {
      const d = new Date(r.data);
      return d >= inicio && d <= fim;
    }).length;
    dados.push(count);
  }

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: semanas,
      datasets: [{
        label: 'Reservas',
        data: dados,
        backgroundColor: '#680505',
        borderRadius: 6
      }]
    },
    options: {
      responsive: true,
      plugins: { legend: { display: false } },
      scales: { y: { beginAtZero: true } }
    }
  });
}

// Iniciar
hoje();
