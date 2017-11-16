QingEditor.lang({
	source : 'HTML����',
	selectall : 'ȫѡ(Ctrl+A)',
	justifyleft : '�����',
	justifycenter : '����',
	justifyright : '�Ҷ���',
	justifyfull : '���˶���',
	insertorderedlist : '���',
	insertunorderedlist : '��Ŀ����',
	indent : '��������',
	outdent : '��������',
	subscript : '�±�',
	superscript : '�ϱ�',
	formatblock : '����',
	fontname : '����',
	fontsize : '���ִ�С',
	forecolor : '������ɫ',
	hilitecolor : '���ֱ���',
	bold : '����(Ctrl+B)',
	italic : 'б��(Ctrl+I)',
	underline : '�»���(Ctrl+U)',
	strikethrough : 'ɾ����',
	removeformat : 'ɾ����ʽ',
	image : 'ͼƬ',
	table : '���',
	hr : '�������',
	emoticons : '�������',
	link : '��������',
	unlink : 'ȡ����������',
	fullscreen : 'ȫ����ʾ',
	about : '����',
	lineheight : '�о�',
	clearhtml : '����HTML����',
	pagebreak : '�����ҳ��',
	quickformat : 'һ���Ű�',
	insertfile : '�����ļ�',
	template : '����ģ��',
	anchor : 'ê��',
	yes : 'ȷ��',
	no : 'ȡ��',
	close : '�ر�',
	editLink : '������������',
	deleteLink : 'ȡ����������',
	editAnchor : 'ê������',
	deleteAnchor : 'ɾ��ê��',
	noColor : '����ɫ',
	invalidImg : "��������Ч��URL��ַ��\nֻ����jpg,gif,bmp,png��ʽ��",
	invalidUrl : "��������Ч��URL��ַ��",

}, 'zh-CN');

QingEditor.options.langType = 'zh-CN';


			var editor;
			QingEditor.ready(function(K) {
				editor = K.create('textarea[name="'+textarea_name+'"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist']
				});
			});