<template>
  <div>
    <h1>Teams</h1>
    <table class="table table-sm table-dark table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Navn</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="!teams.length">
          <td colspan="2" class="norows">
            Ingen hold tilføjet endnu.
          </td>
        </tr>
        <tr v-for="team in teams" :key="team.id">
          <td :style="{backgroundColor: team.background_color}">
            <h4 :style="{color: team.font_color}">{{ team.name }}</h4>
          </td>
          <td style="width: 200px;">
            <button type="button" class="btn btn-danger" @click="destroy(team.id)">
              <b-icon-trash /> Slet hold
            </button>
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td>
            <input type="text" class="form-control" v-model="name" placeholder="Tilføj hold">
          </td>
          <td>
            <v-swatches v-model="background_color">
              <button slot="trigger" type="button" name="button" class="btn btn-secondary">
                <b-icon-brush /> Farve
              </button>
            </v-swatches>
            <button class="btn btn-secondary" type="button" @click="create" :disabled="!name && !background_color">Tilføj hold</button>
          </td>
        </tr>
      </tfoot>
    </table>
  </div>
</template>

<script type="text/javascript">
import { Team } from '../services'
import VSwatches from 'vue-swatches'

export default {
  components: { VSwatches },
  data() {
    return {
      name: '',
      background_color: '',
      teams: []
    }
  },
  methods: {
    destroy(team_id) {
      Team.delete({game_id: this.game_id, id: team_id}).then(() => {
        this.$emit('input', this.teams);
        this.query();
      })
    },
    create() {
      let data = {
        name: this.name,
        background_color: this.background_color
      };
      Team.save({game_id: this.game_id}, data).then(() => {
        this.name = '';
        this.$emit('input', this.teams);
        this.query();
      })
    },
    query() {
      Team.query({game_id: this.game_id}).then((response) => {
        this.teams = response;
      });
    }
  },
  props: {
    game_id: {
      type: String,
      required: true
    }
  },
  created() {
    this.query()
  }
}
</script>
