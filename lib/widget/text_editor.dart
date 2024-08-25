import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TextEditor extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreated;
  final String title;
  final bool needTitleBar;

  const TextEditor(
      {super.key,
      required this.onCreated,
      required this.title,
      this.needTitleBar = false});

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                final result = {
                  'title': _titleController.text,
                  'content': _contentController.text,
                };
                widget.onCreated(result);
              },
              child: const Text(
                "发表",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (widget.needTitleBar)
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: '输入标题...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  if (widget.needTitleBar) const SizedBox(height: 16),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        hintText: '在这里输入 Markdown 文本...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(16.0),
                        alignLabelWithHint: true,
                      ),
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Markdown(
                data: _titleController.text.isNotEmpty
                    ? "# ${_titleController.text}\n${_contentController.text}"
                    : _contentController.text),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
