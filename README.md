# 代码生成实例项目
![image](https://github.com/lesleytong/xtend/blob/master/%E8%AF%B4%E6%98%8E.png)
## 项目结构

## 运行原理
在运行TestGenerator后，程序首先会读取src/Table.xml，将其中而信息读入后，调用Generator中的generate方法，该方法会根据XML文件中的信息产生代码，并将其打印在控制台中。

## 作业要求
1. 阅读并理解代码
2. 扩展Generator.xtend，为每个生成的类自动生成默认的构造函数，利用table.xml中对每个field中defaultValue的信息设置属性的默认值。
3. 扩展Generator.xtend，使得在生成属性的同时还会为这个属性产生对应的get、set方法
4. 扩展Generator.xtend，为每个生成的类自动生成一个向数据库插入记录的代码，并假设存在一个可以调用的executeSQL(String sql)函数，你需要做的是产生SQL语句。

## 例子
假设有如下的XML输入文件：
```
<?xml version="1.0" encoding="UTF-8"?>
<tables>
  <table id="user" tablen="90">
    <field name="id" len="6" datatype="int(5)" defaultValue="1"/>
    <field name="name" len="32" datatype="varchar(32)" defaultValue="hero"/>
    <field name="password" len="32" datatype="varchar(32)" defaultValue="233333"/>
  </table>
</tables>
```

这个文件定义了一个table元素（id为user），其中包含了三个field子元素。根据这个文件，我们期望生成的Java代码如下：
```
public class User {
  private int id;
  private String name;
  private String password;

  public User() {
    this.id = 1;
    this.name = "hero";
    this.password = "233333";
  }

  public int getId() {
    return this.id;
  }
  public void setId(int id) {
    this.id = id;
  }
  public String getName() {
    return this.name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getPassword() {
    return this.password;
  }
  public void setPassword(String password) {
    this.password = password;
  }
  
  static public void createTable() {
    String sql = "CREATE TABLE user(id int(5),name varchar(32),password varchar(32))";
    executeSQL(sql);
  }
  
  public void insert() {
    String sql = "INSERT INTO user VALUES("+id+",'"+name+"','"+password+"')";
    executeSQL(sql);
  }
}
```
