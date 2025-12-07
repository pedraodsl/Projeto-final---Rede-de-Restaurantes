// rendM.js - Totalmente dinâmico
document.addEventListener('DOMContentLoaded', async () => {
  const modoBtn = document.getElementById('modo-btn');
  const hamburger = document.getElementById('hamburger');
  const navLinks = document.getElementById('nav-links');

  let vendas = {};
  let chart;

  // === CARREGAR DADOS ===
  try {
    const res = await fetch('dados/vendas.json');
    if (!res.ok) throw new Error('Dados não encontrados');
    vendas = await res.json();
  } catch (err) {
    document.body.innerHTML += '<p style="color:red; text-align:center;">Erro ao carregar dados de vendas</p>';
    console.error(err);
    return;
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

  // === MENU MOBILE ===
  hamburger.addEventListener('click', () => {
    navLinks.classList.toggle('show');
    hamburger.innerHTML = navLinks.classList.contains('show') ? '×' : 'Menu';
  });

  // === CÁLCULOS ===
  const hoje = new Date();
  const inicioSemana = new Date(hoje);
  inicioSemana.setDate(hoje.getDate() - hoje.getDay());
  const inicioMes = new Date(hoje.getFullYear(), hoje.getMonth(), 1);

  let totalHoje = 0, totalSemana = 0, totalMes = 0, totalAcumulado = 0;

  Object.entries(vendas).forEach(([dataStr, valor]) => {
    const data = new Date(dataStr);
    totalAcumulado += valor;

    if (data.toDateString() === hoje.toDateString()) totalHoje += valor;
    if (data >= inicioSemana) totalSemana += valor;
    if (data >= inicioMes) totalMes += valor;
  });

  // === ATUALIZAR CARDS ===
  document.getElementById('hoje').textContent = totalHoje.toLocaleString('pt-BR', {minimumFractionDigits: 2});
  document.getElementById('semana').textContent = totalSemana.toLocaleString('pt-BR', {minimumFractionDigits: 2});
  document.getElementById('mes').textContent = totalMes.toLocaleString('pt-BR', {minimumFractionDigits: 2});
  document.getElementById('total-acumulado').textContent = totalAcumulado.toLocaleString('pt-BR', {minimumFractionDigits: 2});

  // === GRÁFICO ANUAL ===
  const anos = ['2019','2020','2021','2022','2023','2024','2025'];
  const dadosAnuais = anos.map(ano => {
    return Object.entries(vendas)
      .filter(([d]) => d.startsWith(ano))
      .reduce((soma, [_, v]) => soma + v, 0);
  });

  const ctx = document.getElementById('growthChart').getContext('2d');
  chart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: anos,
      datasets: [{
        label: 'Receita Anual',
        data: dadosAnuais,
        borderColor: '#c9a96c',
        backgroundColor: 'rgba(201,169,108,0.2)',
        tension: 0.4,
        fill: true,
        pointRadius: 6
      }]
    },
    options: {
      responsive: true,
      plugins: { legend: { display: false } },
      scales: { y: { beginAtZero: true } }
    }
  });
});