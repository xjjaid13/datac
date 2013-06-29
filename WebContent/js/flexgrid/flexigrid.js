(function($){
	$.addFlex = function(t,p){
		if (t.grid) return false;
		p = $.extend({
			 colModel : false,
			 height: 200,
			 width: 'auto',
			 striped: false,
			 novstripe: false,
			 minwidth: 30,
			 minheight: 80,
			 resizable: true,
			 url: false,
			 method: 'POST',
			 dataType: 'json',
			 errormsg: '连接错误',
			 usepager: false,
			 nowrap: true,
			 page: 1,
			 total: 1,
			 useRp: true,
			 rp: 15,
			 rpOptions: [10,15,20,25,40],
			 title: true,
			 pagestat: '{from}-{to}/{total}条数据',
			 pagetext: '页数',
			 outof: 'of',
			 findtext: '查找',
			 procmsg: '处理中，请稍后 ...',
			 query: '',
			 qtype: '',
			 nomsg: '没有数据',
			 minColToggle: 1,
			 checkboxindex : 'id',
			 showToggleBtn: true,
			 hideOnSubmit: true,
			 autoload: true,
			 isSelect : false,
			 blockOpacity: 0.5,
			 onDragCol: false,
			 onToggleCol: false,
			 onChangeSort: false,
			 onSuccess: false,
			 onError: false,
			 onSubmit: false
		  }, p);
		$(t).show().attr({cellPadding: 0, cellSpacing: 0, border: 0}).removeAttr('width');
		var g = {
			addData : function(data){
				$('.pReload',this.pDiv).removeClass('loading');this.loading = false;
				if (!data) {$('.pPageStat',this.pDiv).html(p.errormsg);return false;}
				p.total = data.total;
				if (p.total==0){
					$('tr, a, td, div',t).unbind();
					$(t).empty();
					p.pages = 1;
					p.page = 1;
					this.buildpager();
					$('.pPageStat',this.pDiv).html(p.nomsg);
					return false;
				}
				p.pages = Math.ceil(p.total/p.rp);
				p.page = data.page;
				this.buildpager();
				var tbody = document.createElement('tbody');
				$.each(data.rows,function(i,row){
					var tr = document.createElement('tr');
					if (i % 2 && p.striped) tr.className = 'erow';
					if (row.id){tr.id = 'row' + row.id;}
					$('thead tr:first th',g.hDiv).each(function(){
						var idx = $(this).attr('abbr');
						if(p.isSelect && idx == p.checkboxindex){
							$(tr).append("<td><input type=\"checkbox\" value=\""+row[idx]+"\"></td>");
						}else{
							var td = document.createElement('td');
							td.align = this.align;
							td.innerHTML = row[idx];
							$(tr).append(td);
							td = null;
						}
					});
					if ($('thead',this.gDiv).length<1){
						for (idx=0;idx<cell.length;idx++){
							var td = document.createElement('td');
							td.innerHTML = row[idx];
							$(tr).append(td);
							td = null;
						}
					}
					$(tbody).append(tr);
					tr = null;
				});
				$('tr',t).unbind();
				$(t).empty();
				$(t).append(tbody);
				this.addCellProp();
				this.addRowProp();
				tbody = null; data = null; i = null;
				$("#select_text").click(function(){g.doSearch();});
				if (p.onSuccess){
					p.onSuccess();
				}
				if (p.hideOnSubmit){
					$(g.block).remove();
				}
				this.hDiv.scrollLeft = this.bDiv.scrollLeft;
				if ($.browser.opera) $(t).css('visibility','visible');
			},
			changeSort: function(th) {
				if (this.loading){return true;}
				$(g.nDiv).hide();
				if (p.sortname == $(th).attr('abbr') && $(th).attr('sort')){
					if (p.sortorder=='asc'){p.sortorder = 'desc';
					}else{p.sortorder = 'asc';}
				}
				$('.sdesc',this.hDiv).removeClass('sdesc');
				$('.sasc',this.hDiv).removeClass('sasc');
				if($(th).attr('sort')){$('div',th).addClass('s'+p.sortorder);}
				p.sortname= $(th).attr('abbr');
				if (p.onChangeSort){p.onChangeSort(p.sortname,p.sortorder);
				}else{this.populate();}
			},
			buildpager: function(){
				$('.pcontrol input',this.pDiv).val(p.page);
				$('.pcontrol span',this.pDiv).html(p.pages);
				var r1 = (p.page-1) * p.rp + 1; 
				var r2 = r1 + p.rp - 1; 
				if (p.total<r2) r2 = p.total;
				var stat = p.pagestat;
				stat = stat.replace(/{from}/,r1);
				stat = stat.replace(/{to}/,r2);
				stat = stat.replace(/{total}/,p.total);
				$('.pPageStat',this.pDiv).html(stat);
			},
			populate: function() {
				if (this.loading){return true;}
				if (p.onSubmit){
					var gh = p.onSubmit();
					if (!gh) return false;
				}
				this.loading = true;
				if (!p.url) return false;
				$('.pPageStat',this.pDiv).html(p.procmsg);
				$('.pReload',this.pDiv).addClass('loading');
				$(g.block).css({top:g.bDiv.offsetTop});
				if (p.hideOnSubmit) $(this.gDiv).prepend(g.block);
				if ($.browser.opera) $(t).css('visibility','hidden');
				if (!p.newp) p.newp = 1;
				if (p.page>p.pages) p.page = p.pages;
				var param = [
					 { name : 'page', value : p.newp }
					,{ name : 'rp', value : p.rp }
					,{ name : 'sortname', value : p.sortname}
					,{ name : 'sortorder', value : p.sortorder }
					,{ name : 'query', value : p.query}
					,{ name : 'qtype', value : p.qtype}
				];							 
				if (p.params){
					for (var pi = 0; pi < p.params.length; pi++) param[param.length] = p.params[pi];
				}
				$.ajax({
				   type: p.method,
				   url: p.url,
				   data: param,
				   dataType: p.dataType,
				   success: function(data){g.addData(data);},
				   error: function(XMLHttpRequest, textStatus, errorThrown) { 
					   try { if (p.onError) p.onError(XMLHttpRequest, textStatus, errorThrown); } catch (e) {} }
				 });
			},
			doSearch: function () {
				p.query = $("#query").val();
				this.populate();
			},
			changePage: function(ctype){
				if (this.loading) return true;
				p.query = $("#query").val();
				switch(ctype){
					case 'first': p.newp = 1; break;
					case 'prev': if (p.page>1) p.newp = parseInt(p.page) - 1; break;
					case 'next': if (p.page<p.pages) p.newp = parseInt(p.page) + 1; break;
					case 'last': p.newp = p.pages; break;
					case 'input': 
						var nv = parseInt($('.pcontrol input',this.pDiv).val());
						if(isNaN(nv)){nv = 1;}
						if (nv<1){nv = 1;
						}else if(nv > p.pages){nv = p.pages;}
						$('.pcontrol input',this.pDiv).val(nv);
						p.newp =nv;
						break;
				}
				if (p.newp==p.page){return false;}
				if (p.onChangePage){
					p.onChangePage(p.newp);
				}else{
					this.populate();
				}		
			},
			addCellProp: function(){
				$('tbody tr td',g.bDiv).each(function(){
					var tdDiv = document.createElement('div');
					var n = $('td',$(this).parent()).index(this);
					var pth = $('th:eq('+n+')',g.hDiv).get(0);
					if (pth!=null){
						$(tdDiv).css({textAlign:pth.align,width: $('div:first',pth)[0].style.width});
						if (pth.hide) $(this).css('display','none');
					}
					if (p.nowrap==false) $(tdDiv).css('white-space','normal');
					if (this.innerHTML=='') this.innerHTML = '&nbsp;';
					tdDiv.innerHTML = this.innerHTML;
					var prnt = $(this).parent()[0];
					var pid = false;
					if (prnt.id) pid = prnt.id.substr(3);
					if (pth!=null){
						if (pth.process) pth.process(tdDiv,pid);
					}
					$(this).empty().append(tdDiv).removeAttr('width');
				});
			},getCellDim: function (obj){
				var ht = parseInt($(obj).height());
				var pht = parseInt($(obj).parent().height());
				var wt = parseInt(obj.style.width);
				var pwt = parseInt($(obj).parent().width());
				var top = obj.offsetParent.offsetTop;
				var left = obj.offsetParent.offsetLeft;
				var pdl = parseInt($(obj).css('paddingLeft'));
				var pdt = parseInt($(obj).css('paddingTop'));
				return {ht:ht,wt:wt,top:top,left:left,pdl:pdl, pdt:pdt, pht:pht, pwt: pwt};
			},addRowProp: function(){
				$('tbody tr',g.bDiv).each(function(){
					$(this).click(function(e){
						var obj = (e.target || e.srcElement); if (obj.href || obj.type) return true;
						$(this).toggleClass('trSelected');
						if (p.singleSelect) $(this).siblings().removeClass('trSelected');
					}).hover(function (e){ 
						if (g.multisel){
							$(this).toggleClass('trSelected'); 
						}
					},function(){});
					if ($.browser.msie&&$.browser.version<7.0){
						$(this).hover(
							function () { $(this).addClass('trOver'); },
							function () { $(this).removeClass('trOver'); }
						);
					}
				});
			},pager: 0};		
		if (p.colModel){
			thead = document.createElement('thead');
			tr = document.createElement('tr');
			if(p.isSelect){
				$(tr).append("<th align=left abbr=id><input id=\"selectall\" type=\"checkbox\"></th>");
			}
			for (i=0;i<p.colModel.length;i++){
				var cm = p.colModel[i];
				var th = document.createElement('th');
				th.innerHTML = cm.display;
				if (cm.name){
					$(th).attr('abbr',cm.name);
				}
				if(cm.sortable){
					$(th).attr('sort',cm.sortable);
				}
				$(th).attr('axis','col'+i);
				if (cm.align) th.align = cm.align;
				if (cm.width) $(th).attr('width',cm.width);
				if (cm.hide) th.hide = true;
				if (cm.process) th.process = cm.process;
				$(tr).append(th);
			}
			$(thead).append(tr);
			$(t).prepend(thead);
		}

		g.gDiv = document.createElement('div'); //create global container
		g.hDiv = document.createElement('div'); //create header container
		g.bDiv = document.createElement('div'); //create body container
		g.vDiv = document.createElement('div'); //create grip
		g.rDiv = document.createElement('div'); //create horizontal resizer
		g.cDrag = document.createElement('div'); //create column drag
		g.block = document.createElement('div'); //creat blocker
		g.nDiv = document.createElement('div'); //create column show/hide popup
		g.iDiv = document.createElement('div'); //create editable layer
		g.tDiv = document.createElement('div'); //create toolbar
		g.sDiv = document.createElement('div');
		
		if (p.usepager) g.pDiv = document.createElement('div'); //create pager container
		g.hTable = document.createElement('table');

		g.gDiv.className = 'flexigrid';
		if (p.width!='auto') g.gDiv.style.width = p.width + 'px';

		if ($.browser.msie) $(g.gDiv).addClass('ie');
		
		if (p.novstripe) $(g.gDiv).addClass('novstripe');
		$(t).before(g.gDiv);
		$(g.gDiv).append(t);

		if (p.buttons){
			g.tDiv.className = 'tDiv';
			var tDiv2 = document.createElement('div');
			tDiv2.className = 'tDiv2';
			for (i=0;i<p.buttons.length;i++){
					var btn = p.buttons[i];
					if (!btn.separator){
						var btnDiv = document.createElement('div');
						btnDiv.className = 'fbutton';
						btnDiv.innerHTML = "<div><span>"+btn.name+"</span></div>";
						if (btn.bclass){$('span',btnDiv).addClass(btn.bclass).css({paddingLeft:20});}
						btnDiv.onpress = btn.onpress;
						btnDiv.name = btn.name;
						if (btn.onpress){
							$(btnDiv).click(function(){
								this.onpress(this.name,g.gDiv);
							});
						}
						$(tDiv2).append(btnDiv);
						if ($.browser.msie&&$.browser.version<7.0){
							$(btnDiv).hover(function(){$(this).addClass('fbOver');},function(){$(this).removeClass('fbOver');});
						}
					} else {
						$(tDiv2).append("<div class='btnseparator'></div>");
					}
				}
				$(g.tDiv).append(tDiv2);
				$(g.tDiv).append("<div style='clear:both'></div>");
				$(g.gDiv).prepend(g.tDiv);
		}
		g.hDiv.className = 'hDiv';
		$(t).before(g.hDiv);
		g.hTable.cellPadding = 0;
		g.hTable.cellSpacing = 0;
		$(g.hDiv).append('<div class="hDivBox"></div>');
		$('div',g.hDiv).append(g.hTable);
		var thead = $("thead:first",t).get(0);
		if (thead) $(g.hTable).append(thead);
		thead = null;
		if (!p.colmodel){var ci = 0;}

		$('thead tr:first th',g.hDiv).each(function(){
			var $abbr = $(this).attr('abbr');
			var $sort = $(this).attr('sort');
			var thdiv = document.createElement('div');
			if ($abbr){
				if($sort){
					$(this).click(function (e){
						var obj = (e.target || e.srcElement);
						if(obj.href || obj.type) {return true;}
						g.changeSort(this);
					});
					if ($abbr==p.sortname){
						thdiv.className = 's'+p.sortorder;
					}
				}else{
					$(this).click(function(){
						if($(this).find(":checkbox").attr("checked") == "checked"){
							$(':checkbox',g.bDiv).attr("checked","checked");
						}else{
							$(':checkbox',g.bDiv).removeAttr("checked");
						}
					});
				}
			}
			if(this.hide){$(this).hide();}
			if (!p.colmodel){
				$(this).attr('axis','col' + ci++);
			}
			$(thdiv).css({textAlign:this.align,width:this.width+'px'});
			thdiv.innerHTML = this.innerHTML;
			
			$(this).empty().append(thdiv).removeAttr('width').hover(function(){
				if($(this).attr('abbr')!=p.sortname && $(this).attr('abbr')!='id' && $(this).attr('sort')){$('div',this).addClass('s'+p.sortorder);}
				else if($(this).attr('abbr')==p.sortname && $(this).attr('sort')){
					var no = '';
					if (p.sortorder=='asc'){no = 'desc';}
					else{no = 'asc';}
					$('div',this).removeClass('s'+p.sortorder).addClass('s'+no);
				}
				var nv = $('th:visible',g.hDiv).index(this);
				var onl = parseInt($('div:eq('+nv+')',g.cDrag).css('left'));
				$(g.nDiv).hide();
				var ndw = parseInt($(g.nDiv).width());
				$(g.nDiv).css({top:g.bDiv.offsetTop});
			},function(){
				if ($(this).attr('abbr')!=p.sortname){$('div',this).removeClass('s'+p.sortorder);}
				else if($(this).attr('abbr')==p.sortname){
					var no = '';
					if (p.sortorder=='asc') no = 'desc';
					else no = 'asc';
					$('div',this).addClass('s'+p.sortorder).removeClass('s'+no);
				}
			});
		});

		g.bDiv.className = 'bDiv';
		$(t).before(g.bDiv);
		$(g.bDiv).css({ height: (p.height=='auto') ? 'auto' : p.height+"px"}).append(t);
		
		if (p.height == 'auto'){
			$('table',g.bDiv).addClass('autoht');
		}
		g.addCellProp();
		g.addRowProp();
		
		var cdcol = $('thead tr:first th:first',g.hDiv).get(0);
		
		if (cdcol != null){		
			g.cdpad = 0;
			
			g.cdpad += (isNaN(parseInt($('div',cdcol).css('borderLeftWidth'))) ? 0 : parseInt($('div',cdcol).css('borderLeftWidth'))); 
			g.cdpad += (isNaN(parseInt($('div',cdcol).css('borderRightWidth'))) ? 0 : parseInt($('div',cdcol).css('borderRightWidth'))); 
			g.cdpad += (isNaN(parseInt($('div',cdcol).css('paddingLeft'))) ? 0 : parseInt($('div',cdcol).css('paddingLeft'))); 
			g.cdpad += (isNaN(parseInt($('div',cdcol).css('paddingRight'))) ? 0 : parseInt($('div',cdcol).css('paddingRight'))); 
			g.cdpad += (isNaN(parseInt($(cdcol).css('borderLeftWidth'))) ? 0 : parseInt($(cdcol).css('borderLeftWidth'))); 
			g.cdpad += (isNaN(parseInt($(cdcol).css('borderRightWidth'))) ? 0 : parseInt($(cdcol).css('borderRightWidth'))); 
			g.cdpad += (isNaN(parseInt($(cdcol).css('paddingLeft'))) ? 0 : parseInt($(cdcol).css('paddingLeft'))); 
			g.cdpad += (isNaN(parseInt($(cdcol).css('paddingRight'))) ? 0 : parseInt($(cdcol).css('paddingRight'))); 
	
			var cdheight = $(g.bDiv).height();
			var hdheight = $(g.hDiv).height();
			
			$('thead tr:first th',g.hDiv).each(function(){
				var cgDiv = document.createElement('div');
				if (!p.cgwidth) p.cgwidth = $(cgDiv).width();
				$(cgDiv).css({height: cdheight + hdheight});
			});
		}
		if (p.usepager){
			g.pDiv.className = 'pDiv';
			g.pDiv.innerHTML = '<div class="pDiv2"></div>';
			$(g.bDiv).after(g.pDiv);
			var html = ' <div class="pGroup"> <div class="pFirst pButton"><span></span></div><div class="pPrev pButton"><span></span></div> </div> <div class="btnseparator"></div> <div class="pGroup"><span class="pcontrol">'+p.pagetext+' <input type="text" size="4" value="1" /> '+p.outof+' <span> 1 </span></span></div> <div class="btnseparator"></div> <div class="pGroup"> <div class="pNext pButton"><span></span></div><div class="pLast pButton"><span></span></div> </div> <div class="btnseparator"></div> <div class="pGroup"> <div class="pReload pButton"><span></span></div> </div> <div class="btnseparator"></div> <div class="pGroup"><span class="pPageStat"></span></div>';
			$('div',g.pDiv).html(html);
			$('.pReload',g.pDiv).click(function(){g.populate();});
			$('.pFirst',g.pDiv).click(function(){g.changePage('first');});
			$('.pPrev',g.pDiv).click(function(){g.changePage('prev');});
			$('.pNext',g.pDiv).click(function(){g.changePage('next');});
			$('.pLast',g.pDiv).click(function(){g.changePage('last');});
			$('.pcontrol input',g.pDiv).keydown(function(e){if(e.keyCode==13) g.changePage('input');});
			if ($.browser.msie&&$.browser.version<7) $('.pButton',g.pDiv).hover(function(){$(this).addClass('pBtnOver');},function(){$(this).removeClass('pBtnOver');});
				if (p.useRp){
					var opt = "";
					for (var nx=0;nx<p.rpOptions.length;nx++){
						if (p.rp == p.rpOptions[nx]) sel = 'selected="selected"'; else sel = '';
						 opt += "<option value='" + p.rpOptions[nx] + "' " + sel + " >" + p.rpOptions[nx] + "&nbsp;&nbsp;</option>";
					};
					$('.pDiv2',g.pDiv).prepend("<div class='pGroup'><select name='rp'>"+opt+"</select></div> <div class='btnseparator'></div>");
					$('select',g.pDiv).change(function(){
						if (p.onRpChange) 
							p.onRpChange(+this.value);
						else{
							p.newp = 1;
							p.rp = +this.value;
							g.populate();
						}
					});
				}
			if (p.searchitems){
				$('.pDiv2',g.pDiv).prepend("<div class='pGroup'> <div class='pSearch pButton'><span></span></div> </div>  <div class='btnseparator'></div>");
				$('.pSearch',g.pDiv).click(function(){$(g.sDiv).slideToggle('fast',function(){$('.sDiv:visible input:first',g.gDiv).trigger('focus');});});				
				g.sDiv.className = 'sDiv';
				sitems = p.searchitems;
				var sopt = "";
				for (var s = 0; s < sitems.length; s++){
					if (p.qtype=='' && sitems[s].isdefault==true){
						p.qtype = sitems[s].name;
						sel = 'selected="selected"';
					}else sel = '';
					sopt += "<option value='" + sitems[s].name + "' " + sel + " >" + sitems[s].display + "&nbsp;&nbsp;</option>";						
				}
				sopt += "　<input type='button' id='select_text' value='查找'>";
				if (p.qtype==''){p.qtype = sitems[0].name;}
				$(g.sDiv).append("<div class='sDiv2'>"+p.findtext+" <input type='text' size='30' name='query' id='query' class='qsbox' /> <select name='qtype'>"+sopt+"</select> <!--input type='button' value='Clear' /--></div>");
				$(g.bDiv).after(g.sDiv);				
			}
		}
		$(g.pDiv,g.sDiv).append("<div style='clear:both'></div>");
		g.cdropleft = document.createElement('span');
		g.cdropleft.className = 'cdropleft';
		g.cdropright = document.createElement('span');
		g.cdropright.className = 'cdropright';

		g.block.className = 'gBlock';
		var gh = $(g.bDiv).height();
		var gtop = g.bDiv.offsetTop;
		$(g.block).css({
			width: g.bDiv.style.width,
			height: gh,
			background: 'white',
			position: 'relative',
			marginBottom: (gh * -1),
			zIndex: 1,
			top: gtop,
			left: '0px'
		});
		$(g.block).fadeTo(0,p.blockOpacity);				
		if ($('th',g.hDiv).length){
			g.nDiv.className = 'nDiv';
			g.nDiv.innerHTML = "<table cellpadding='0' cellspacing='0'><tbody></tbody></table>";
			$(g.nDiv).css({
				marginBottom: (gh * -1),
				display: 'none',
				top: gtop
			}).noSelect();
			var cn = 0;
			$('th div',g.hDiv).each(function (){
						var kcol = $("th[axis='col" + cn + "']",g.hDiv)[0];
						var chk = 'checked="checked"';
						if (kcol.style.display=='none') chk = '';
						$('tbody',g.nDiv).append('<tr><td class="ndcol1"><input type="checkbox" '+ chk +' class="togCol" value="'+ cn +'" /></td><td class="ndcol2">'+this.innerHTML+'</td></tr>');
						cn++;
			});
			if ($.browser.msie&&$.browser.version<7.0)
				$('tr',g.nDiv).hover(
				 	function () {$(this).addClass('ndcolover');},
					function () {$(this).removeClass('ndcolover');}
				);
			$(g.gDiv).prepend(g.nDiv);
		}
		$(g.iDiv).addClass('iDiv').css({display:'none'});
		$(g.bDiv).append(g.iDiv);
		$(g.gDiv).hover(function(){},function(){$(g.nDiv).hide();});
		
		if ($.browser.msie&&$.browser.version<7.0){
			$('.hDiv,.bDiv,.mDiv,.pDiv,.vGrip,.tDiv, .sDiv',g.gDiv).css({width: '100%'});
			$(g.gDiv).addClass('ie6');
			if (p.width!='auto') $(g.gDiv).addClass('ie6fullwidthbug');			
		} 
		t.p = p;
		t.grid = g;
		if (p.url&&p.autoload){
			g.populate();
		}
		return t;		
	};
	var docloaded = false;
	$(document).ready(function () {docloaded = true;} );
	$.fn.flexigrid = function(p) {
		return this.each( function(){
			if (!docloaded){
				$(this).hide();
				var t = this;
				$(document).ready(
					function (){
						$.addFlex(t,p);
					}
				);
			} else {
				$.addFlex(this,p);
			}
		});
	};
	$.fn.flexReload = function(p) {
		return this.each( function() {
			if (this.grid&&this.p.url){
				this.grid.populate();
			}
		});

	};

	$.fn.flexOptions = function(p) { //function to update general options
		return this.each( function() {
			if (this.grid) $.extend(this.p,p);
		});
	};

	$.fn.flexToggleCol = function(cid,visible) { // function to reload grid
		return this.each( function() {
			if (this.grid) this.grid.toggleCol(cid,visible);
		});
	};

	$.fn.flexAddData = function(data) { // function to add data to grid
		return this.each( function() {
			if (this.grid) this.grid.addData(data);
		});
	};

	$.fn.noSelect = function(p) { //no select plugin by me :-)
		if (p == null){prevent = true;}
		else{prevent = p;}
		if (prevent){
			return this.each(function(){
				if ($.browser.msie||$.browser.safari) $(this).bind('selectstart',function(){return false;});
				else if ($.browser.mozilla){
					$(this).css('MozUserSelect','none');
					$('body').trigger('focus');
				}else if($.browser.opera){$(this).bind('mousedown',function(){return false;});}
				else{$(this).attr('unselectable','on');}
			});
		} else {
			return this.each(function (){
				if ($.browser.msie||$.browser.safari){$(this).unbind('selectstart');}
				else if($.browser.mozilla){$(this).css('MozUserSelect','inherit');}
				else if ($.browser.opera){$(this).unbind('mousedown');}
				else{$(this).removeAttr('unselectable','on');}
			});
		}
	};
})(jQuery);
