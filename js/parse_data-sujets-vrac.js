var rows;
var title;
var content;
var table_start;
var table_end;
var table_content;
var table_header;
var table_body;
table_start = "<table>";
table_header = "<thead><tr>";
table_end = "</table>";
Papa.parse(
  "https://raw.githubusercontent.com/eyssette/ressources-generales-enseignement-philosophie/master/sujets-vrac.tsv",
  {
    download: true,
    header: false,
    delimiter: "    ",
    complete: function (results) {
      rows = results.data;
      title = rows[0][0].split("\t");
      table_header = table_header + "<th>" + title + "</th>";
      table_header = table_header + "</tr></thead>";
      rows = rows.splice(1, rows.length);
      table_body = "<tbody>";
      rows.forEach((element) => {
        recherche = document.getElementById("recherche_dans_le_sujet").value;
        console.log(recherche);
        table_body = table_body + "<tr>";
        cell = element[0];
        table_body = table_body + "<td>" + cell + "</td>";
        table_body = table_body + "</tr>";
      });
      table_body = table_body + "</tbody>";
      content = table_start + table_header + table_body + table_end;
      document.getElementById("content").innerHTML = content;
    }
  }
);
let input = document.querySelector("input");
input.oninput = handleInput;

function handleInput(e) {
  search = e.target.value;
  search_items = search.split("+");
  pattern = "";
  search_items.forEach((search_item) => {
    pattern = pattern + "(?=.*" + search_item + ")";
  });
  regex = new RegExp(pattern);
  table_body = "<tbody>";
  rows.forEach((element) => {
    cell = element[0];
    if (cell.toString().match(regex)) {
      table_body = table_body + "<tr>";
      table_body = table_body + "<td>" + cell + "</td>";
      table_body = table_body + "</tr>";
    }
  });
  table_body = table_body + "</tbody>";
  content = table_start + table_header + table_body + table_end;
  document.getElementById("content").innerHTML = content;
}