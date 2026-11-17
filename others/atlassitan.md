# Atlassian tools

## Confluence

1. Auto number heading

Add this script into a bookmark, and click (run) it in the editting mode of Confluence

  ```javascript
  javascript:(function(){var pm=document.querySelector('.ak-editor-content-area .ProseMirror');var el=pm,k=null;while(el&&!k){k=Object.keys(el).find(function(x){return x.indexOf('__reactFiber$')==0||x.indexOf('__reactInternalInstance$')==0;});if(!k)el=el.parentNode;}var f=k&&el[k],view=null;while(f&&!view){var s=f.stateNode,p=f.memoizedProps;if(s&&s.view&&s.view.dom===pm)view=s.view;else if(p&&p.editorView&&p.editorView.dom===pm)view=p.editorView;f=f.return;}if(!view){alert('EditorView not found');return;}var st=view.state,re=/^\s*\d+(\.\d+)*\.?(\s+|$)/,idx=[],ops=[];st.doc.descendants(function(n,pos){if(n.type.name!=='heading')return;var h=n.attrs.level-1;if(idx.length-1>h)idx=idx.slice(0,h+1);if(idx[h]==undefined)idx[h]=0;idx[h]++;var t=idx.join('.')+'. ',c=n.firstChild,len=0;if(c&&c.isText){var m=c.text.match(re);if(m)len=m[0].length;if(len&&c.text.slice(0,len)===t&&!c.marks.length)return false;}ops.push({from:pos+1,to:pos+1+len,t:t});return false;});if(!ops.length)return;var tr=st.tr;for(var i=ops.length-1;i>=0;i--){tr.replaceWith(ops[i].from,ops[i].to,st.schema.text(ops[i].t));}view.dispatch(tr);})()
  ```

2. Remove numberings from headings

   Add this script into a bookmark, and click (run) it in the editting mode of Confluence

  ```javascript
  javascript:(function(){var pm=document.querySelector('.ak-editor-content-area .ProseMirror');var el=pm,k=null;while(el&&!k){k=Object.keys(el).find(function(x){return x.indexOf('__reactFiber$')==0||x.indexOf('__reactInternalInstance$')==0;});if(!k)el=el.parentNode;}var f=k&&el[k],view=null;while(f&&!view){var s=f.stateNode,p=f.memoizedProps;if(s&&s.view&&s.view.dom===pm)view=s.view;else if(p&&p.editorView&&p.editorView.dom===pm)view=p.editorView;f=f.return;}if(!view){alert('EditorView not found');return;}var st=view.state,re=/^\d+(\.\d+)*\.\s+/,ops=[];st.doc.descendants(function(n,pos){if(n.type.name!=='heading')return;var c=n.firstChild;if(c&&c.isText){var m=c.text.match(re);if(m)ops.push({from:pos+1,to:pos+1+m[0].length});}return false;});if(!ops.length)return;var tr=st.tr;for(var i=ops.length-1;i>=0;i--){tr.delete(ops[i].from,ops[i].to);}view.dispatch(tr);})()
  ````
