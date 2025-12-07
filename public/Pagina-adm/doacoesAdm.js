// doacoesAdm.js → Totalmente dinâmico com fetch()
document.addEventListener('DOMContentLoaded', async () => {
  const modoBtn = document.getElementById('modo-btn');
  const hamburger = document.getElementById('hamburger');
  const navLinks = document.getElementById('nav-links');
  const dataFiltro = document.getElementById('data-filtro');
  const btnHoje = document.getElementById('btn-hoje');
  const btnLimpar = document.getElementById('btn-limpar');
  const dataTitulo = document.getElementById('data-titulo');
  const totalDiaSpan = document.getElementById('total-dia');
  const tabelaBody = document.querySelector('#tabela-doacoes tbody');
  const btnsPeriod = document.querySelectorAll('.btn-period');

  let chart;
  let dadosDoacoes = {}; // será preenchido com o JSON
  let periodoAtual = 'semana';

  // === CARREGAR DADOS DO JSON ===
  try {
    const res = await fetch('dados/doacoes.json');
    if (!res.ok) throw new Error('Não foi possível carregar os dados');
    dadosDoacoes = await res.json();
  } catch (err) {
    console.error(err);
    tabelaBody.innerHTML = '<tr><td colspan="3" style="text-align:center; color:red;">Erro ao carregar dados</td></tr>';
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

  // === CRIAR GRÁFICO DINÂMICO ===
  function criarGrafico(periodo) {
    const ctx = document.getElementById('doacoesChart').getContext('2d');
    const hoje = new Date();
    const labels = [];
    const valores = [];

    if (periodo === 'semana') {
      for (let i = 11; i >= 0; i--) {
        const inicioSemana = new Date(hoje);
        inicioSemana.setDate(hoje.getDate() - i * 7);
        inicioSemana.setHours(0,0,0,0);
        const fimSemana = new Date(inicioSemana);
        fimSemana.setDate(inicioSemana.getDate() + 6);

        const totalSemana = Object.keys(dadosDoacoes)
          .filter(data => {
            const d = new Date(data);
            return d >= inicioSemana && d <= fimSemana;
          })
          .reduce((soma, data) => {
            return soma + dadosDoacoes[data].reduce((acc, d) => acc + d.valor, 0);
          }, 0);

        labels.push(i === 0 ? 'Esta semana' : `Semana ${i}`);
        valores.push(totalSemana);
      }
    } else {
      const meses = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
      for (let i = 11; i >= 0; i--) {
        const data = new Date(hoje);
        data.setMonth(hoje.getMonth() - i);
        const mes = data.getMonth();
        const ano = data.getFullYear();

        const totalMes = Object.keys(dadosDoacoes)
          .filter(data => {
            const d = new Date(data);
            return d.getMonth() === mes && d.getFullYear() === ano;
          })
          .reduce((soma, data) => soma + dadosDoacoes[data].reduce((acc, d) => acc + d.valor, 0), 0);

        labels.push(`${meses[mes]}/${ano.toString().slice(2)}`);
        valores.push(totalMes);
      }
    }

    if (chart) chart.destroy();

    chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels,
        datasets: [{
          label: 'Valor Total Doado (R$)',
          data: valores,
          backgroundColor: 'rgba(201, 169, 108, 0.8)',
          borderColor: '#c9a96c',
          borderWidth: 2,
          borderRadius: 6
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { position: 'top' } },
        scales: {
          y: { beginAtZero: true }
        }
      }
    });
  }

  // === MOSTRAR DOAÇÕES DO DIA ===
  function mostrarDoacoes(dataStr) {
    const doacoes = dadosDoacoes[dataStr] || [];
    tabelaBody.innerHTML = '';
    let total = 0;

    if (doacoes.length === 0) {
      tabelaBody.innerHTML = '<tr><td colspan="3" style="text-align:center; padding:2rem; color:#999;">Nenhuma doação nesta data.</td></tr>';
      totalDiaSpan.textContent = '0,00';
      dataTitulo.textContent = formatarData(dataStr);
      return;
    }

    doacoes.forEach(d => {
      total += d.valor;
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${d.hora}</td><td>${d.cliente}</td><td>R$ ${d.valor.toFixed(2).replace('.', ',')}</td>`;
      tabelaBody.appendChild(tr);
    });

    totalDiaSpan.textContent = total.toFixed(2).replace('.', ',');
    dataTitulo.textContent = formatarData(dataStr);
  }

  function formatarData(str) {
    if (!str) return 'Hoje';
    const data = new Date(str);
    return data.toLocaleDateString('pt-BR', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
  }

  // === EVENTOS ===
  btnsPeriod.forEach(btn => {
    btn.addEventListener('click', () => {
      btnsPeriod.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      periodoAtual = btn.dataset.period;
      criarGrafico(periodoAtual);
    });
  });

  btnHoje.onclick = () => {
    const hoje = new Date().toISOString().split('T')[0];
    dataFiltro.value = hoje;
    mostrarDoacoes(hoje);
  };

  btnLimpar.onclick = () => {
    dataFiltro.value = '';
    btnHoje.click();
  };

  dataFiltro.addEventListener('change', () => {
    if (dataFiltro.value) mostrarDoacoes(dataFiltro.value);
  });

  // === INICIAR ===
  criarGrafico('semana');
  btnHoje.click();
});