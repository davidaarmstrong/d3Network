#' Basic HTML Header
#'
#' @keywords internals
#' @noRd

BasicHead <- function(){
"<!DOCTYPE html>
<meta charset=\"utf-8\">
<body> "
}

BasicHeadNet <- function(){
    "<!DOCTYPE html>
<meta charset=\"utf-8\">
<body> 
<button onclick=\"resetFunction()\">reset</button>\n
<div id=\"fig\"></div>\n"
}



#' Mustache basic CSS template for d3Network
#'
#' @keywords internals
#' @noRd

BasicStyleSheet <- function(){
"<style>
.link {
stroke: {{linkColour}};
opacity: {{opacity}};
stroke-width: 1.5px;
}
.node circle {
stroke: #fff;
opacity: {{opacity}};
stroke-width: 1.5px;
}
text {
font: {{fontsize}}px serif;
opacity: {{opacity}};
pointer-events: none;
}
</style>

<script src={{d3Script}}></script>

<script> \n"
}

#' Mustache CSS template for d3ForceNetwork
#'
#' @keywords internals
#' @noRd

ForceMainStyleSheet <- function(){
"<style>
.link {
stroke: {{linkColour}};
opacity: {{opacity}};
stroke-width: 1.5px;
}
.node circle {
stroke: #fff;
opacity: {{opacity}};
stroke-width: 1.5px;
}
.node:not(:hover) .nodetext {
display: none;
}
text {
font: {{fontsize}}px serif;
opacity: {{opacity}};
pointer-events: none;
}
</style>

<script src={{d3Script}}></script>

<script> \n"
}

#' Mustache CSS template for d3ForceNetwork
#'
#' @keywords internals
#' @noRd

TreeStyleSheet <- function(){
"<style>
.link {
fill: none;
stroke: {{linkColour}};
opacity: {{linkOpacity}};
stroke-width: 1.5px;
}
.node circle {
stroke: #fff;
opacity: {{opacity}};
stroke-width: 1.5px;
}
.node:not(:hover) .nodetext {
display: none;
}
text {
font: {{fontsize}}px serif;
opacity: {{opacity}};
pointer-events: none;
}
</style>

<script src={{d3Script}}></script>

<script> \n"
}

#' Mustache Sankey
#'
#' @keywords internals
#' @noRd

SankeyStylesheet <- function(){
"<style>
#{{parentElement}} {
height: 500px;
}
.node rect {
cursor: move;
fill-opacity: .9;
shape-rendering: crispEdges;
}
.node text {
font: {{fontsize}}px serif;
pointer-events: none;
text-shadow: 0 1px 0 #fff;
}
.link {
fill: none;
stroke: #000;
stroke-opacity: .2;
}
.link:hover {
stroke-opacity: .5;
}
</style>

<p id=\"{{parentElement}}\"></p>

<script src={{d3Script}}></script>\n"
}


#' Mustache basic Force Directed Network template for d3SimpleNetwork
#'
#' @keywords internals
#' @noRd

BasicForceJS <- function(){
"var nodes = {}

// Compute the distinct nodes from the links.
links.forEach(function(link) {
link.source = nodes[link.source] ||
(nodes[link.source] = {name: link.source});
link.target = nodes[link.target] ||
(nodes[link.target] = {name: link.target});
link.value = +link.value;
});

var width = {{width}}
height = {{height}};

var force = d3.layout.force()
.nodes(d3.values(nodes))
.links(links)
.size([width, height])
.linkDistance({{linkDistance}})
.charge({{charge}})
.on(\"tick\", tick)
.start();

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height);

var link = svg.selectAll(\".link\")
.data(force.links())
.enter().append(\"line\")
.attr(\"class\", \"link\");


var node = svg.selectAll(\".node\")
.data(force.nodes())
.enter().append(\"g\")
.attr(\"class\", \"node\")
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout)
.on(\"click\", click)
.on(\"dblclick\", dblclick)
.call(force.drag);


node.append(\"circle\")
.attr(\"r\", 8)
.style(\"fill\", \"{{nodeColour}}\");

node.append(\"text\")
.attr(\"x\", 12)
.attr(\"dy\", \".35em\")
.style(\"fill\", \"{{textColour}}\")
.text(function(d) { return d.name; });

function tick() {
link
.attr(\"x1\", function(d) { return d.source.x; })
.attr(\"y1\", function(d) { return d.source.y; })
.attr(\"x2\", function(d) { return d.target.x; })
.attr(\"y2\", function(d) { return d.target.y; });

node.attr(\"transform\", function(d) { return \"translate(\" + d.x + \",\" + d.y + \")\"; });
}

function mouseover() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 16);
}

function mouseout() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 8);
}
// action to take on mouse click
function click() {
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"x\", 22)
.style(\"stroke-width\", \".5px\")
.style(\"opacity\", 1)
.style(\"fill\", \"{{nodeClickColour}}\")
.style(\"font\", \"{{clickTextSize}}px serif\");
d3.select(this).select(\"circle\").transition()
.duration(750)
.style(\"fill\", \"{{nodeClickColour}}\")
.attr(\"r\", 16)
}

// action to take on mouse double click
function dblclick() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 6)
.style(\"fill\", \"{{nodeClickColour}}\");
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"x\", 12)
.style(\"stroke\", \"none\")
.style(\"fill\", \"{{nodeClickColour}}\")
.style(\"stroke\", \"none\")
.style(\"opacity\", {{opacity}})
.style(\"font\", \"{{fontsize}}px serif\");
}

</script>\n"
}

#' Mustache main Force Directed Network template for d3ForceNetwork
#'
#' @keywords internals
#' @noRd

MainForceJS <- function(){
"var width = {{width}}
height = {{height}};

var color = d3.scale.category20();

var selectedClasses=[];

var resetFunction = function(){
    document.querySelectorAll(\".selected\").forEach(d => d.classList.remove(\"selected\"));
    document.querySelectorAll(\".unselected\").forEach(d => d.classList.remove(\"unselected\"));
    d3.selectAll(\"g\").style(\"opacity\", {{opacity}});
    d3.selectAll(\"line\").style(\"opacity\", {{opacity}});
    selectedClasses = [];    
}


var force = d3.layout.force()
.nodes(d3.values(nodes))
.links(links)
.size([width, height])
.linkDistance({{linkDistance}})
.charge({{charge}})
.on(\"tick\", tick)
.start();

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height);

var link = svg.selectAll(\".link\")
.data(force.links())
.enter().append(\"line\")
.attr(\"class\", \"link\")
.style(\"stroke-width\", {{linkWidth}})
.style(\"stroke\", function(d) { return color(d.stroke)});

var node = svg.selectAll(\".node\")
.data(force.nodes())
.enter().append(\"g\")
.style(\"fill\", function(d) { return color(d.group); })
.style(\"opacity\", {{opacity}})
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout)
.on(\"click\", myClick)
.call(force.drag);

node
.filter(d => d.shape == \"2\")
  .attr(\"class\", \"node s2\")
  .append(\"circle\")
  .attr(\"r\", 8)
  .style(\"fill\", \"{{nodeColour}}\")

node
.filter(d => d.shape === \"1\")
  .attr(\"class\", \"node s1\")
  .append(\"rect\")
  .attr(\"width\", 20)
  .attr(\"height\", 20)
  .attr(\"x\", -10) // -1/2 * width
  .attr(\"y\", -10) // -1/2 * height
  .attr(\"fill\", \"{{nodeColour}}\");

node.append(\"svg:text\")
.attr(\"class\", \"nodetext\")
.attr(\"dx\", 12)
.attr(\"dy\", \".35em\")
.text(function(d) { return d.text });


var n = document.querySelectorAll(\".node\");
for(i=0; i<n.length; i++){
    n[i].classList.add(nodes[i].group);
};

function tick() {
link
.attr(\"x1\", function(d) { return d.source.x; })
.attr(\"y1\", function(d) { return d.source.y; })
.attr(\"x2\", function(d) { return d.target.x; })
.attr(\"y2\", function(d) { return d.target.y; });

node.attr(\"transform\", function(d) { return \"translate(\" + d.x + \",\" + d.y + \")\"; });
}


function mouseover() {
if(selectedClasses.length === 0){
    var myId = d3.select(this)[0][0].__data__.name
    var myLinks = d3.selectAll(\".link\")[0]
    var m; 
    for(m = 0; m < myLinks.length; m++){
        if(myLinks[m].__data__.source.name === myId || 
           myLinks[m].__data__.target.name === myId){
           d3.selectAll(\".link\")[0][m].classList.add(\"oselected\"); 
           }
           else{
               d3.selectAll(\".link\")[0][m].classList.add(\"unoselected\"); 
           }
    }
    var selNodes = d3.selectAll(\".oselected\")[0]
    var st = [myId]; 
    var i; 
    for(i = 0; i < selNodes.length; i++){
      if(!(st.includes(d3.selectAll(\".oselected\")[0][i].__data__.source.name))){
        st.push(d3.selectAll(\".oselected\")[0][i].__data__.source.name)
      }
      if(!(st.includes(d3.selectAll(\".oselected\")[0][i].__data__.target.name))){
        st.push(d3.selectAll(\".oselected\")[0][i].__data__.target.name)
      }
    }
    var myNodes = d3.selectAll(\".node\")[0]
    var j; 
    for(j = 0; j < myNodes.length; j++){
        if(st.includes(myNodes[j].__data__.name )){
            d3.selectAll(\".node\")[0][j].classList.add(\"oselected\"); 
        }else{
            d3.selectAll(\".node\")[0][j].classList.add(\"unoselected\"); 
        }
    }
    d3.selectAll(\".unoselected\").style(\"opacity\", .1); 
    d3.selectAll(\".oselected\").style(\"opacity\", 1); 
    d3.select(this).select(\"text\").transition()
        .duration(750)
        .attr(\"x\", 13)
        .style(\"stroke-width\", \".5px\")
        .style(\"font\", \"{{clickTextSize}}px serif\")
        .style(\"opacity\", 1);

} else{
d3.select(this).select(\"text\").transition()
    .duration(750)
    .attr(\"x\", 13)
    .style(\"stroke-width\", \".5px\")
    .style(\"font\", \"{{clickTextSize}}px serif\")
    .style(\"opacity\", 1);
}
}

function mouseout() {
    if(selectedClasses.length === 0){
        document.querySelectorAll(\".oselected\").forEach(d => d.classList.remove(\"oselected\"));
        document.querySelectorAll(\".unoselected\").forEach(d => d.classList.remove(\"unoselected\"));
        d3.selectAll(\"g\").style(\"opacity\", {{opacity}});
        d3.selectAll(\"line\").style(\"opacity\", {{opacity}});
    }
}
var allGroups = [];
    var m;
    for(m = 0; m < nodes.length; m++){
        if(!(allGroups.includes(nodes[m].group))){
        allGroups.push(nodes[m].group)
        }
    }

var ag =  new Set(allGroups); 



function myClick() {
    var sel = d3.select(this)[0][0].classList[2];
    if(selectedClasses.includes(sel)){
        selectedClasses.splice(selectedClasses.indexOf(sel), 1);
    } else{
        selectedClasses.push(sel); 
    }
    var sg = new Set(selectedClasses); 
    var i; 
    for(i = 0; i < selectedClasses.length; i++){
        var selNodes = document.querySelectorAll(`.${selectedClasses[i]}`)
        var j; 
        for(j = 0; j < selNodes.length; j++){
            selNodes[j].classList.add(\"selected\");
            selNodes[j].classList.remove(\"unselected\");
        }
    }
    var myLinks = d3.selectAll(\".link\")[0]
        var m; 
        for(m = 0; m < myLinks.length; m++){
            if(selectedClasses.includes(myLinks[m].__data__.source.group) && 
               selectedClasses.includes(myLinks[m].__data__.target.group)){
               d3.selectAll(\".link\")[0][m].classList.add(\"selected\"); 
               d3.selectAll(\".link\")[0][m].classList.remove(\"unselected\"); 
               }
               else{
                   d3.selectAll(\".link\")[0][m].classList.remove(\"selected\"); 
                   d3.selectAll(\".link\")[0][m].classList.add(\"unselected\"); 
               }
        }

    var unselClasses = new Set(
        [...ag].filter(x => !sg.has(x)));
    var unselClasses = Array.from(unselClasses);
    var i; 
    for(i = 0; i < unselClasses.length; i++){
        var unselNodes = document.querySelectorAll(`.${unselClasses[i]}`)
        var j; 
        for(j = 0; j < unselNodes.length; j++){
            unselNodes[j].classList.add(\"unselected\");
            unselNodes[j].classList.remove(\"selected\");
        }
    }
    d3.selectAll(\".unselected\").style(\"opacity\", .1); 
    d3.selectAll(\".selected\").style(\"opacity\", 1); 
    
    
}





</script>\n"
}

#' Mustache main Force Directed Network template for d3ForceNetwork with zooming capabilities.
#'
#' @keywords internals
#' @noRd

ForceZoomJS <- function(){
"var width = {{width}}
height = {{height}};

var color = d3.scale.category20();

var force = d3.layout.force()
.nodes(d3.values(nodes))
.links(links)
.size([width, height])
.linkDistance({{linkDistance}})
.charge({{charge}})
.on(\"tick\", tick)
.start();

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height)
.attr(\"pointer-events\", \"all\")
.call(d3.behavior.zoom().on(\"zoom\", redraw));

var vis = svg
.append(\"svg:g\");

vis.append(\"svg:rect\")
.attr(\"width\", width)
.attr(\"height\", height)
.attr(\"fill\", 'white');

function redraw() {
vis.attr(\"transform\",
\"translate(\" + d3.event.translate + \")\"
+ \" scale(\" + d3.event.scale + \")\");
}

var link = vis.selectAll(\".link\")
.data(force.links())
.enter().append(\"line\")
.attr(\"class\", \"link\")
.style(\"stroke-width\", {{linkWidth}});

var node = vis.selectAll(\".node\")
.data(force.nodes())
.enter().append(\"g\")
.attr(\"class\", \"node\")
.style(\"fill\", function(d) { return color(d.group); })
.style(\"opacity\", {{opacity}})
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout)
.call(force.drag);

node.append(\"circle\")
.attr(\"r\", 6)

node.append(\"svg:text\")
.attr(\"class\", \"nodetext\")
.attr(\"dx\", 12)
.attr(\"dy\", \".35em\")
.text(function(d) { return d.name });

function tick() {
link
.attr(\"x1\", function(d) { return d.source.x; })
.attr(\"y1\", function(d) { return d.source.y; })
.attr(\"x2\", function(d) { return d.target.x; })
.attr(\"y2\", function(d) { return d.target.y; });

node.attr(\"transform\", function(d) { return \"translate(\" + d.x + \",\" + d.y + \")\"; });
}

function mouseover() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 16);
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"x\", 13)
.style(\"stroke-width\", \".5px\")
.style(\"font\", \"{{clickTextSize}}px serif\")
.style(\"opacity\", 1);
}

function mouseout() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 8);
}

</script>\n"
}

#' Mustache main (1) Reingold-Tilford Tree network graph template for d3Tree.
#'
#' @keywords internals
#' @noRd

MainRTTree1 <- function(){
"var width = {{width}}
height = {{height}};

var diameter = {{diameter}};

var tree = d3.layout.tree()
.size([360, diameter / 2 - 120])
.separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

var diagonal = d3.svg.diagonal.radial()
.projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height)
.append(\"g\")
.attr(\"transform\", \"translate(\" + diameter / 2 + \",\" + diameter / 2 + \")\"); \n"
}

#' Mustache main (2) Reingold-Tilford Tree network graph template for d3Tree.
#'
#' @keywords internals
#' @noRd

MainRTTree2 <- function(){
"var nodes = tree.nodes(root),
links = tree.links(nodes);

var link = svg.selectAll(\".link\")
.data(links)
.enter().append(\"path\")
.attr(\"class\", \"link\")
.attr(\"d\", diagonal);

var node = svg.selectAll(\".node\")
.data(nodes)
.enter().append(\"g\")
.attr(\"class\", \"node\")
.attr(\"transform\", function(d) { return \"rotate(\" + (d.x - 90) + \")translate(\" + d.y + \")\"; })
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout);

node.append(\"circle\")
.attr(\"r\", 4.5)
.style(\"fill\", \"{{nodeColour}}\");

node.append(\"text\")
.attr(\"dy\", \".31em\")
.attr(\"text-anchor\", function(d) { return d.x < 180 ? \"start\" : \"end\"; })
.attr(\"transform\", function(d) { return d.x < 180 ? \"translate(8)\" : \"rotate(180)translate(-8)\"; })
.style(\"fill\", \"{{textColour}}\")
.text(function(d) { return d.name; });

function mouseover() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 9)
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"dy\", \".31em\")
.attr(\"text-anchor\", function(d) { return d.x < 180 ? \"start\" : \"end\"; })
.attr(\"transform\", function(d) { return d.x < 180 ? \"translate(8)\" : \"rotate(180)translate(-8)\"; })
.style(\"stroke-width\", \".5px\")
.style(\"font\", \"{{fontsizeBig}}px serif\")
.style(\"opacity\", 1);
}

function mouseout() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 4.5)
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"dy\", \".31em\")
.attr(\"text-anchor\", function(d) { return d.x < 180 ? \"start\" : \"end\"; })
.attr(\"transform\", function(d) { return d.x < 180 ? \"translate(8)\" : \"rotate(180)translate(-8)\"; })
.style(\"font\", \"{{fontsize}}px serif\")
.style(\"opacity\", {{opacity}});
}

d3.select(self.frameElement).style(\"height\", diameter - 150 + \"px\");

</script>\n"
}

#' Mustache Zooming (1) Reingold-Tilford Tree network graph template for d3Tree.
#'
#' @keywords internals
#' @noRd

ZoomRTTree1 <- function(){
"var width = {{width}}
height = {{height}};

var diameter = {{diameter}};

var tree = d3.layout.tree()
.size([360, diameter / 2 - 120])
.separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

var diagonal = d3.svg.diagonal.radial()
.projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height)
.attr(\"pointer-events\", \"all\")
.call(d3.behavior.zoom().on(\"zoom\", redraw));

var vis = svg
.append(\"svg:g\");

vis.append(\"svg:rect\")
.attr(\"width\", width)
.attr(\"height\", height)
.attr(\"fill\", 'white');

function redraw() {
vis.attr(\"transform\",
\"translate(\" + d3.event.translate + \")\"
+ \" scale(\" + d3.event.scale + \")\");
}

\n"
}

#' Mustache Zooming (2) Reingold-Tilford Tree network graph template for d3Tree.
#'
#' @keywords internals
#' @noRd

ZoomRTTree2 <- function(){
"var nodes = tree.nodes(root),
links = tree.links(nodes);

var link = vis.selectAll(\".link\")
.data(links)
.enter().append(\"path\")
.attr(\"class\", \"link\")
.attr(\"d\", diagonal);

var node = vis.selectAll(\".node\")
.data(nodes)
.enter().append(\"g\")
.attr(\"class\", \"node\")
.attr(\"transform\", function(d) { return \"rotate(\" + (d.x - 90) + \")translate(\" + d.y + \")\"; })
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout)

node.append(\"circle\")
.attr(\"r\", 4.5)
.style(\"fill\", \"{{nodeColour}}\");

node.append(\"svg:text\")
.attr(\"dy\", \".31em\")
.attr(\"text-anchor\", function(d) { return d.x < 180 ? \"start\" : \"end\"; })
.attr(\"transform\", function(d) { return d.x < 180 ? \"translate(8)\" : \"rotate(180)translate(-8)\"; })
.style(\"fill\", \"{{textColour}}\")
.text(function(d) { return d.name; });

function mouseover() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 9)
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"dy\", \".31em\")
.attr(\"text-anchor\", function(d) { return d.x < 180 ? \"start\" : \"end\"; })
.attr(\"transform\", function(d) { return d.x < 180 ? \"translate(8)\" : \"rotate(180)translate(-8)\"; })
.style(\"stroke-width\", \".5px\")
.style(\"font\", \"{{fontsizeBig}}px serif\")
.style(\"opacity\", 1);
}

function mouseout() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 4.5)
d3.select(this).select(\"text\").transition()
.duration(750)
.attr(\"dy\", \".31em\")
.attr(\"text-anchor\", function(d) { return d.x < 180 ? \"start\" : \"end\"; })
.attr(\"transform\", function(d) { return d.x < 180 ? \"translate(8)\" : \"rotate(180)translate(-8)\"; })
.style(\"font\", \"{{fontsize}}px serif\")
.style(\"opacity\", {{opacity}});
}

d3.select(self.frameElement).style(\"height\", diameter - 150 + \"px\");

</script>\n"
}

#' Mustache Main (1) Cluster Dendrogram graphs template for d3Cluster.
#'
#' @keywords internals
#' @noRd

MainClusterDendro1 <- function(){
"var width = {{width}}
height = {{height}};

var cluster = d3.layout.cluster()
.size([height - height * {{heightCollapse}}, width - width * {{widthCollapse}}]);

var diagonal = d3.svg.diagonal()
.projection(function(d) { return [d.y, d.x]; });

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height)
.append(\"g\")
.attr(\"transform\", \"translate(40,0)\");
\n"
}

#' Mustache Main (2) Cluster Dendrogram graphs template for d3Cluster.
#'
#' @keywords internals
#' @noRd

MainClusterDendro2 <- function(){
"var nodes = cluster.nodes(root),
links = cluster.links(nodes);

var link = svg.selectAll(\".link\")
.data(links)
.enter().append(\"path\")
.attr(\"class\", \"link\")
.attr(\"d\", diagonal);

var node = svg.selectAll(\".node\")
.data(nodes)
.enter().append(\"g\")
.attr(\"class\", \"node\")
.attr(\"transform\", function(d) { return \"translate(\" + d.y + \",\" + d.x + \")\"; })
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout);

node.append(\"circle\")
.attr(\"r\", 4.5)
.style(\"fill\", \"{{nodeColour}}\");

node.append(\"text\")
.attr(\"dx\", function(d) { return d.children ? -8 : 8; })
.attr(\"dy\", 3)
.style(\"text-anchor\", function(d) { return d.children ? \"end\" : \"start\"; })
.style(\"fill\", \"{{textColour}}\")
.text(function(d) { return d.name; });

function mouseover() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 9)
d3.select(this).select(\"text\").transition()
.duration(750)
.style(\"stroke-width\", \".5px\")
.style(\"font\", \"{{fontsizeBig}}px serif\")
.style(\"opacity\", 1);
}

function mouseout() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 4.5)
d3.select(this).select(\"text\").transition()
.duration(750)
.style(\"font\", \"{{fontsize}}px serif\")
.style(\"opacity\", {{opacity}});
}

d3.select(self.frameElement).style(\"height\", height + \"px\");

</script>
\n"
}

#' Mustache Zoom (1) Cluster Dendrogram graphs template for d3Cluster.
#'
#' @keywords internals
#' @noRd

ZoomClusterDendro1 <- function(){
"var width = {{width}}
height = {{height}};

var cluster = d3.layout.cluster()
.size([height - height * {{heightCollapse}}, width - width * {{widthCollapse}}]);

var diagonal = d3.svg.diagonal()
.projection(function(d) { return [d.y, d.x]; });

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width)
.attr(\"height\", height)
.attr(\"pointer-events\", \"all\")
.call(d3.behavior.zoom().on(\"zoom\", redraw));

var vis = svg
.append(\"svg:g\");

vis.append(\"svg:rect\")
.attr(\"width\", width)
.attr(\"height\", height)
.attr(\"fill\", 'white');

function redraw() {
vis.attr(\"transform\",
\"translate(\" + d3.event.translate + \")\"
+ \" scale(\" + d3.event.scale + \")\");
}
\n"
}

#' Mustache Zoom (2) Cluster Dendrogram graphs template for d3Cluster.
#'
#' @keywords internals
#' @noRd

ZoomClusterDendro2 <- function(){
"var nodes = cluster.nodes(root),
links = cluster.links(nodes);

var link = vis.selectAll(\".link\")
.data(links)
.enter().append(\"path\")
.attr(\"class\", \"link\")
.attr(\"d\", diagonal);

var node = vis.selectAll(\".node\")
.data(nodes)
.enter().append(\"g\")
.attr(\"class\", \"node\")
.attr(\"transform\", function(d) { return \"translate(\" + d.y + \",\" + d.x + \")\"; })
.on(\"mouseover\", mouseover)
.on(\"mouseout\", mouseout);

node.append(\"circle\")
.attr(\"r\", 4.5)
.style(\"fill\", \"{{nodeColour}}\");

node.append(\"svg:text\")
.attr(\"dx\", function(d) { return d.children ? -8 : 8; })
.attr(\"dy\", 3)
.style(\"text-anchor\", function(d) { return d.children ? \"end\" : \"start\"; })
.style(\"fill\", \"{{textColour}}\")
.text(function(d) { return d.name; });

function mouseover() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 9)
d3.select(this).select(\"text\").transition()
.duration(750)
.style(\"stroke-width\", \".5px\")
.style(\"font\", \"{{fontsizeBig}}px serif\")
.style(\"opacity\", 1);
}

function mouseout() {
d3.select(this).select(\"circle\").transition()
.duration(750)
.attr(\"r\", 4.5)
d3.select(this).select(\"text\").transition()
.duration(750)
.style(\"font\", \"{{fontsize}}px serif\")
.style(\"opacity\", {{opacity}});
}

d3.select(self.frameElement).style(\"height\", height + \"px\");

</script>
\n"
}

#' Mustache for d3Sankey.
#'
#' @keywords internals
#' @noRd

SankeyJS <- function(){
"var margin = {top: 1, right: 1, bottom: 6, left: 1},
width = {{width}} - margin.left - margin.right,
height = {{height}} - margin.top - margin.bottom;

var formatNumber = d3.format(\",.0f\"),
format = function(d) { return formatNumber(d); },
color = d3.scale.category20();

var svg = d3.select(\"{{parentElement}}\").append(\"svg\")
.attr(\"width\", width + margin.left + margin.right)
.attr(\"height\", height + margin.top + margin.bottom)
.append(\"g\")
.attr(\"transform\", \"translate(\" + margin.left + \",\" + margin.top + \")\");

var sankey = d3.sankey()
.nodes(d3.values(nodes))
.links(links)
.nodeWidth({{nodeWidth}})
.nodePadding({{nodePadding}})
.size([width, height])
.layout(32);

var path = sankey.link();

var link = svg.append(\"g\").selectAll(\".link\")
.data(sankey.links())
.enter().append(\"path\")
.attr(\"class\", \"link\")
.attr(\"d\", path)
.style(\"stroke-width\", function(d) { return Math.max(1, d.dy); })
.sort(function(a, b) { return b.dy - a.dy; });

link.append(\"title\")
.text(function(d) { return d.source.name + \" \u2192 \" + d.target.name + \"\\n\" + format(d.value); });

var node = svg.append(\"g\").selectAll(\".node\")
.data(sankey.nodes())
.enter().append(\"g\")
.attr(\"class\", \"node\")
.attr(\"transform\", function(d) { return \"translate(\" + d.x + \",\" + d.y + \")\"; })
.call(d3.behavior.drag()
.origin(function(d) { return d; })
.on(\"dragstart\", function() { this.parentNode.appendChild(this); })
.on(\"drag\", dragmove));

node.append(\"rect\")
.attr(\"height\", function(d) { return d.dy; })
.attr(\"width\", sankey.nodeWidth())
.style(\"fill\", function(d) { return d.color = color(d.name.replace(/ .*/, \"\")); })
.style(\"stroke\", function(d) { return d3.rgb(d.color).darker(2); })
.append(\"title\")
.text(function(d) { return d.name + \"\\n\" + format(d.value); });

node.append(\"text\")
.attr(\"x\", -6)
.attr(\"y\", function(d) { return d.dy / 2; })
.attr(\"dy\", \".35em\")
.attr(\"text-anchor\", \"end\")
.attr(\"transform\", null)
.text(function(d) { return d.name; })
.filter(function(d) { return d.x < width / 2; })
.attr(\"x\", 6 + sankey.nodeWidth())
.attr(\"text-anchor\", \"start\");

function dragmove(d) {
d3.select(this).attr(\"transform\", \"translate(\" + d.x + \",\" + (d.y = Math.max(0, Math.min(height - d.dy, d3.event.y))) + \")\");
sankey.relayout();
link.attr(\"d\", path);
}

</script>\n
"
}
