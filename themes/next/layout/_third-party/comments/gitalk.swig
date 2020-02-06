{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
{% if theme.gitalk.enable and theme.gitalk.clientID %}
<!-- LOCAL: You can save these files to your site and update links -->
    <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
    <!--<script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>-->
    <script src="https://geektutu.github.io/hexo-theme-geektutu/js/gitalk.min.js"></script>
<!-- END LOCAL -->
      <script type="text/javascript">
          let str = location.pathname
          if(str.substr(str.length-1,str.length)=="/") {
            str=str.substr(0,str.length-1);
          }
          let index = str.lastIndexOf("\/");  
          str  = str.substring(index + 1, str.length);
          var gitalk = new Gitalk({
               clientID: '{{theme.gitalk.clientID}}',
               clientSecret: '{{theme.gitalk.clientSecret}}',
               repo: '{{theme.gitalk.repo}}',
               owner: '{{theme.gitalk.owner}}',
               admin: ['{{theme.gitalk.admin}}'],
               title: '{{page.title}}',
               id: str,      // Ensure uniqueness and length less than 50
               distractionFreeMode: false  // Facebook-like distraction free mode
               });
        gitalk.render('gitalk-container');
      </script>
{% endif %}
{% endif %}
