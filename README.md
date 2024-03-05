## Container configuration

apache(httpd)
tomcat(Ver.9)
mysql(5.7.33)
admin
Maven development (openjdk11)

## How to deploy containers

```bash
git clone https://github.com/emsnguyen/tomcat-docker-public.git
cd tomcat-docker-public
docker-compose up -d
````

## tomcat project URL

```bash
http://localhost:8080/war file name/
````

## apache(httpd) project URL

```bash
http://localhost/war file name/
````

## admin (DB management tool)

http://localhost:8081

* Login information
   - Server: mysql_db
   - Username: tomcat
   - Password: password
   - Database: tomcatdb

## maven (java) development environment

### Container login

```bash
docker-compose exec maven /bin/bash
````

### Create tomcat project

```bash
mvn archetype:generate -DgroupId=com.example -DartifactId=my-tomcat-app -Dversion=1.0-SNAPSHOT -DarchetypeArtifactId=maven-archetype-webapp

* "my-tomcat-app" becomes the project name (war file name).
````

Create a servlet in the created "my-tomcat-app".

Place the JSP file in the java source file/webapp in the java folder.

After creating the project, perform the following settings to enable maven build.

```bash
cd {project name}
vi pom.xml

Add the following content within <dependencies>~</dependencies>.

     <dependency>
       <groupId>javax.servlet</groupId>
       <artifactId>javax.servlet-api</artifactId>
       <version>4.0.1</version>
       <scope>provided</scope>
     </dependency>
     <dependency>
       <groupId>javax.servlet.jsp</groupId>
       <artifactId>javax.servlet.jsp-api</artifactId>
       <version>2.3.3</version>
       <scope>provided</scope>
     </dependency>

Add the following content to <build>~</build>.

     <plugins>
       <plugin>
         <groupId>org.apache.maven.plugins</groupId>
         <artifactId>maven-compiler-plugin</artifactId>
         <version>3.8.1</version>
         <configuration>
           <source>11</source>
           <target>11</target>
         </configuration>
       </plugin>
     </plugins>
````

### tomcat servlet sample

Create the following files.

```bash
mkdir src/main/java
vi src/main/java/HelloServlet.java

package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet {
     @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         response.setContentType("text/html");
         response.getWriter().println("<h1>Hello, World!</h1>");
     }
}
````

```bash
vi src/main/webapp/WEB-INF

Add the following content within <web-app>~</web-app>.

   <servlet>
     <servlet-name>HelloServlet</servlet-name>
     <servlet-class>com.example.HelloServlet</servlet-class>
   </servlet>
   <servlet-mapping>
     <servlet-name>HelloServlet</servlet-name>
     <url-pattern>/helloservlet</url-pattern>
   </servlet-mapping>
````

### maven build

```bash
mvn clean package

* A war file is created in the target folder.
Get out of the container.
````

### tomcat build

Place the war file created by maven build in tomcat-docker-public/webapps.

The servlet can be referenced with the following URL.

http://localhost:8080/{project name}/{servlet name}

## apache(httpd)

### Tomcat site reference from apache

Perform the following operations.

```bash
vi tomcat-docker-public/httpd.conf

Add the following to the last line.
ProxyPass /my-tomcat-app http://tomcat:8080/my-tomcat-app
ProxyPassReverse /my-tomcat-app http://tomcat:8080/my-tomcat-app

* Change "my-tomcat-app" (project name) as necessary.
````

Execute container restart.
```bash
docker-compose stop
docker-compose up -d
````

The servlet can be referenced with the following URL.

http://localhost/{project name}/{servlet name}