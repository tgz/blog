{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
{% if theme.gittalk.enable and theme.gittalk.clientID %}
<!-- LOCAL: You can save these files to your site and update links -->
    <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
    <script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>
<!-- END LOCAL -->
      <script type="text/javascript">
          var gitalk = new Gitalk({
               clientID: '{{theme.gittalk.clientID}}',
               clientSecret: '{{theme.gittalk.clientSecret}}',
               repo: '{{theme.gittalk.repo}}',
               owner: '{{theme.gittalk.owner}}',
               admin: [{{theme.gittalk.admin}}],
               id: location.pathname,      // Ensure uniqueness and length less than 50
               distractionFreeMode: false  // Facebook-like distraction free mode
               });
        gitalk.render('gitalk-container');
      </script>
{% endif %}
{% endif %}
