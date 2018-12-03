{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
{% if theme.gitalk.enable and theme.gitalk.clientID %}
<!-- LOCAL: You can save these files to your site and update links -->
    <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
    <script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>
<!-- END LOCAL -->
      <script type="text/javascript">
          var gitalk = new Gitalk({
               clientID: '{{theme.gitalk.clientID}}',
               clientSecret: '{{theme.gitalk.clientSecret}}',
               repo: '{{theme.gitalk.repo}}',
               owner: '{{theme.gitalk.owner}}',
               admin: ['{{theme.gitalk.admin}}'],
               title: '{{page.title}}',
               id: location.pathname,      // Ensure uniqueness and length less than 50
               distractionFreeMode: false  // Facebook-like distraction free mode
               });
        gitalk.render('gitalk-container');
      </script>
{% endif %}
{% endif %}
