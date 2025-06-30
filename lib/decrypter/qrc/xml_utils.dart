import 'package:xml/xml.dart';

/// XML 工具类，提供 XML 处理功能
class XmlUtils {
  /// 用于替换 & 符号的正则表达式，只匹配未转义的 &
  static final RegExp _ampRegex = RegExp(r'&(?![a-zA-Z]{2,6};|#[0-9]{2,4};)');
  
  /// 用于替换引号的正则表达式
  static final RegExp _quotRegex = RegExp(
    r'(\s+[\w:.-]+\s*=\s*")(([^"]*)((")(?!\s+[\w:.-]+\s*=\s*"|\s*(?:/?|\?)>))[^"]*)*)"'
  );
  
  /// 创建 XML DOM
  /// 
  /// [content] XML 内容字符串
  /// 返回解析后的 XML 文档
  static XmlDocument create(String content) {
    // 移除无效内容
    content = _removeIllegalContent(content);
    
    // 替换未转义的 & 符号
    content = _replaceAmp(content);
    
    // 替换引号
    final modifiedContent = _replaceQuot(content);
    
    XmlDocument doc;
    
    try {
      // 尝试解析修改后的内容
      doc = XmlDocument.parse(modifiedContent);
    } catch (_) {
      // 如果解析失败，尝试解析原始内容
      doc = XmlDocument.parse(content);
    }
    
    return doc;
  }
  
  /// 替换未转义的 & 符号
  static String _replaceAmp(String content) {
    return content.replaceAllMapped(_ampRegex, (match) => '&amp;');
  }
  
  /// 替换引号内容
  static String _replaceQuot(String content) {
    final buffer = StringBuffer();
    
    int currentPos = 0;
    for (var match in _quotRegex.allMatches(content)) {
      buffer.write(content.substring(currentPos, match.start));
      
      final firstGroup = match.group(1) ?? '';
      final secondGroup = match.group(2)?.replaceAll('"', '&quot;') ?? '';
      buffer.write('$firstGroup$secondGroup"');
      
      currentPos = match.end;
    }
    
    buffer.write(content.substring(currentPos));
    
    return buffer.toString();
  }
  
  /// 移除 XML 内容中无效的部分
  /// 
  /// [content] 原始 XML 内容
  /// 返回移除后的内容
  static String _removeIllegalContent(String content) {
    var result = content;
    int i = 0;
    
    while (i < result.length) {
      if (result[i] == '<') {
        final leftBracketPos = i;
        
        // 查找右括号位置
        while (i < result.length && result[i] != '>') {
          i++;
        }
        
        if (i > 0 && i < result.length && result[i] == '>' && result[i - 1] == '/') {
          // 找到自闭合标签
          final part = result.substring(leftBracketPos, i + 1);
          
          // 检查是否只有一个等号
          if (part.contains('=') && part.indexOf('=') == part.lastIndexOf('=')) {
            // 检查等号和左括号之间是否有空格
            final part1 = result.substring(leftBracketPos, leftBracketPos + part.indexOf('='));
            if (!part1.trim().contains(' ')) {
              // 删除无效标签，重置索引
              result = result.substring(0, leftBracketPos) + result.substring(i + 1);
              i = 0;
              continue;
            }
          }
        }
      }
      
      i++;
    }
    
    return result.trim();
  }
  
  /// 递归查找 XML DOM
  /// 
  /// [xmlNode] 根节点
  /// [mappingDict] 节点名和结果名的映射
  /// [resDict] 结果集
  static void recursionFindElement(
    XmlNode xmlNode, 
    Map<String, String> mappingDict,
    Map<String, XmlNode> resDict
  ) {
    // 检查节点是否为元素节点并且有名称
    if (xmlNode is XmlElement) {
      final nodeName = xmlNode.name.local;
      if (mappingDict.containsKey(nodeName)) {
        final value = mappingDict[nodeName];
        if (value != null) {
          resDict[value] = xmlNode;
        }
      }
    }
    
    // 检查是否有子节点
    final children = xmlNode.children.where((node) => node is XmlElement).toList();
    if (children.isEmpty) {
      return;
    }
    
    // 递归处理每个子节点
    for (var child in children) {
      recursionFindElement(child, mappingDict, resDict);
    }
  }
} 